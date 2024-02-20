// To parse this JSON data, do
//
//     final poll = pollFromJson(jsonString);

import 'dart:convert';

import 'result.dart';

Poll pollFromJson(String str) => Poll.fromJson(json.decode(str));

String pollToJson(Poll data) => json.encode(data.toJson());

class Poll {
  String? id;
  String? topic;
  int? votesPerVoter;
  Map<String, dynamic>? participants;
  Map<String, Nomination>? nominations;
  Map<String, List<String>>? rankings;

  List<Result>? results;
  String? adminId;
  bool? hasStarted;

  Poll({
    this.id,
    this.topic,
    this.votesPerVoter,
    this.participants,
    this.nominations,
    this.rankings,
    this.results,
    this.adminId,
    this.hasStarted,
  });

  factory Poll.fromJson(Map<String, dynamic> json) => Poll(
        id: json["id"],
        topic: json["topic"],
        votesPerVoter: json["votesPerVoter"],
        participants: json["participants"],
        nominations: Map.from(json["nominations"]!).map(
            (k, v) => MapEntry<String, Nomination>(k, Nomination.fromJson(v))),
        rankings: Map.from(json["rankings"]!).map((k, v) =>
            MapEntry<String, List<String>>(
                k, List<String>.from(v.map((x) => x)))),
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
        adminId: json["adminID"],
        hasStarted: json["hasStarted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "topic": topic,
        "votesPerVoter": votesPerVoter,
        "participants": participants,
        "nominations": Map.from(nominations!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "rankings": Map.from(rankings!).map((k, v) =>
            MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "adminID": adminId,
        "hasStarted": hasStarted,
      };
}

class Nomination {
  String? userId;
  String? name;

  Nomination({
    this.userId,
    this.name,
  });

  factory Nomination.fromJson(Map<String, dynamic> json) => Nomination(
        userId: json["userID"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "userID": userId,
        "name": name,
      };
}
