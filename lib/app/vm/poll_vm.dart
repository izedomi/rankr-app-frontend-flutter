import 'package:flutter/material.dart';
import 'package:rankr_app/app/models/participant.dart';
import 'package:rankr_app/app/models/polls.dart';
import 'package:rankr_app/app/print.dart';
import 'package:rankr_app/app/routes/routes.dart';
import 'package:rankr_app/main.dart';
import 'package:rankr_app/services/jwt_service.dart';
import 'package:rankr_app/services/socket_service.dart';
import 'package:rankr_app/services/storage_service.dart';
import '../../services/network/dio_api_service.dart';
import '../../ui/utils/toast.dart';
import '../constants/app_text.dart';
import '../enum/viewstate.dart';
import '../models/api_response.dart';
import '../models/user.dart';

class PollVM extends ChangeNotifier {
  late ApiResponse _apiResponse;

  Poll? _poll;
  Poll? get poll => _poll;

  User? _user;
  User? get user => _user;

  ViewState _viewState = ViewState.idle;
  ViewState get viewState => _viewState;

  ViewState _createPollViewState = ViewState.idle;
  ViewState get createPollViewState => _createPollViewState;

  // final List<Participant> _participants = [];
  // List<Participant> get participant => _participants;

  String _errMsg = "";
  String get errMsg => _errMsg;

  void setViewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  void setCreatePollViewState(ViewState viewState) {
    _createPollViewState = viewState;
    notifyListeners();
  }

  Future<List<dynamic>> createOrJoinPoll(
      Map<String, dynamic> request, bool createPoll) async {
    try {
      setCreatePollViewState(ViewState.busy);
      String url = createPoll ? "/polls" : "/polls/join";

      printty("create poll request...${request.toString()}");

      _apiResponse = await apiService.postWithAuth(url: url, body: request);

      if (!_apiResponse.success) {
        setCreatePollViewState(ViewState.error);
        return [_apiResponse.code, _apiResponse.message ?? AppText.errorMsg];
      }

      printty("create poll response...${_apiResponse.data.toString()}");

      // printty(_apiResponse.data["poll"].toString());
      // printty(_apiResponse.data.runtimeType.toString());
      // printty("90909");

      //save access token locally
      String accessToken = _apiResponse.data["accessToken"];
      await StorageService.storeAccessToken(accessToken);

      //update poll
      updatePoll(_apiResponse.data["poll"]);

      //Poll has started
      bool pollHasStarted = _apiResponse.data["poll"]["hasStarted"];

      //Poll has ended
      List<dynamic> results = _apiResponse.data["poll"]["results"];
      if (results.isNotEmpty) {
        setCreatePollViewState(ViewState.completed);
        return [206, "Voting for this poll has ended"];
      }

      updateUser(accessToken);

      //join poll
      socketService.joinPoll(accessToken, this);

      setCreatePollViewState(ViewState.completed);
      return [pollHasStarted ? 205 : _apiResponse.code, _apiResponse.data];
    } catch (e) {
      _errMsg = AppText.errorMsg;
      setCreatePollViewState(ViewState.error);
      return [500, _errMsg];
    }
  }

  updatePoll(Map<String, dynamic> data) {
    _poll = Poll.fromJson(data);
    printty("poll rankings: ${_poll?.rankings.toString()}");
    notifyListeners();
  }

  deletePoll() {
    socketService.deletePoll();
  }

  voteStarted() {
    Navigator.pushNamed(navigatorKey.currentContext!, AppRoute.voting);
  }

  computePollResults() {
    socketService.computeResults();
  }

  pollDeleted() async {
    await StorageService.reset();
    Navigator.pushNamedAndRemoveUntil(
        navigatorKey.currentContext!, AppRoute.home, (route) => false);

    Flush.toast(message: "Poll closed and deleted by Admin");
  }

  errorOccured(String msg) {
    printty(msg);
    Flush.toast(message: msg);
  }

  updateUser(String accessToken) async {
    _user = await JwtService.decodeToken(tk: accessToken);
    notifyListeners();
  }

  int getParticipantsCount() {
    // printty(_poll?.participants.toString());
    return _poll?.participants?.values.length ?? 0;
  }

  int getRankingsCount() {
    // printty(_poll?.participants.toString());
    return _poll?.rankings?.values.length ?? 0;
  }

  int getNominationsCount() {
    return _poll?.nominations?.values.length ?? 0;
  }

  getPollAdminName() {
    return _poll?.participants?[_poll?.adminId] ?? "Anonymous";
  }

  isAdmin() {
    return _user?.sub == _poll?.adminId;
  }

  canStartPoll() {
    return getParticipantsCount() > 1 && getNominationsCount() > 2;
  }

  pollHasEnded() {
    return _poll?.results != null && _poll!.results!.isNotEmpty;
  }

  List<Participant> participants() {
    List<Participant> participant = [];
    _poll?.participants?.entries.forEach((el) {
      participant.add(Participant(id: el.key, name: el.value));
    });
    return participant;
  }

  nominations() {
    return _poll?.nominations?.entries.toList();
  }
}
