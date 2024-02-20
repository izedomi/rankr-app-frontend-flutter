import 'package:flutter/material.dart';
import 'package:rankr_app/app/print.dart';
import 'package:rankr_app/services/socket_service.dart';
import '../models/polls.dart';

class RankingVM extends ChangeNotifier {
  List<MapEntry<String, Nomination>> _rankings = [];
  List<MapEntry<String, Nomination>> get rankings => _rankings;

  setRankings(List<MapEntry<String, Nomination>> r) {
    _rankings = r;
    notifyListeners();
  }

  updateRankings(oldIndex, newIndex) {
    MapEntry<String, Nomination> oldN = _rankings[oldIndex];
    MapEntry<String, Nomination> newN = _rankings[newIndex];
    _rankings[oldIndex] = newN;
    _rankings[newIndex] = oldN;
    notifyListeners();
  }

  submitRankings(int votePerVoter) {
    List<String> ranks = [];
    for (int i = 0; i < votePerVoter; i++) {
      ranks.add(_rankings[i].key);
    }
    printty("rankings: $ranks");
    socketService.submitRankings(ranks);
  }
}
