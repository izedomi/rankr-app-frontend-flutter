import 'package:rankr_app/app/constants/app_text.dart';
import 'package:rankr_app/app/constants/socket_events.dart';
import 'package:rankr_app/app/vm/poll_vm.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_io_client/socket_io_client.dart';
import '../app/env/env.dart';
import '../app/print.dart';

class SocketService {
  late io.Socket? socket;
  late PollVM pollVM;

  joinPoll(String accessToken, PollVM vm) async {
    connectToSocket(accessToken);
    pollVM = vm;
  }

  leavePoll() {
    socket?.disconnect();
  }

  deletePoll() {
    socket?.emit(SocketEvents.deletePoll);
  }

  removeParticipant(String participantId) {
    socket?.emit(SocketEvents.removeParticipant, {"id": participantId});
  }

  nominate(String nomination) {
    socket?.emit(SocketEvents.nominate, {"name": nomination});
  }

  removeNomination(String nominationId) {
    socket?.emit(SocketEvents.removeNomination, {"nominationID": nominationId});
  }

  startPoll() {
    socket?.emit(SocketEvents.startVote, {});
  }

  submitRankings(List<String> rankings) {
    socket?.emit(SocketEvents.submitRanking, {"rankings": rankings});
  }

  computeResults() {
    socket?.emit(SocketEvents.computeResult, {});
  }

  Future<void> connectToSocket(String token) async {
    printty("token: $token");
    printty("connecting to socket...${Env().config.baseUrl}/polls");
    socket = io.io(
        "${Env().config.baseUrl}/polls",
        OptionBuilder()
            .setTransports(['websocket'])
            .enableForceNewConnection()
            .setExtraHeaders({
              'token': token
            }) // necessary because otherwise it would reuse old connection
            //.disableAutoConnect()
            .build());

    socket?.connect();
    socket?.onConnectError(
        (data) => printty("Notification: onConnectError: $data"));
    socket?.onError((data) => printty("On Error: $data"));

    socket?.onDisconnect((data) {
      printty("disconnected...$data");
      socket?.on(SocketEvents.pollUpdated, (data) {
        printty("Poll updated: ${data.toString()}");
        pollVM.updatePoll(data);
      });
    });

    socket?.onConnect((_) {
      printty('connected to socket: polls');
      // socket?.emit("join-room", "notify-$id");
    });

    //socket!.on("notify", (msg){});
    socket?.on(SocketEvents.pollUpdated, (data) {
      printty("Poll updated: ${data.toString()}");
      pollVM.updatePoll(data);
    });

    //socket!.on("notify", (msg){});
    socket?.on(SocketEvents.voteStarted, (data) {
      printty("vote started: ");
      pollVM.voteStarted();
    });

    socket?.on(SocketEvents.pollDeleted, (data) {
      printty("poll deleted");
      leavePoll();
      pollVM.pollDeleted();
    });

    socket?.on(SocketEvents.exception, exception);
  }

  exception(data) {
    printty("Exceptions: ${data.toString()}");
    pollVM.errorOccured(data["message"] ?? AppText.errorMsg);
  }
}

SocketService socketService = SocketService();
