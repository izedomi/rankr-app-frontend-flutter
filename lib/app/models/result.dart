// To parse this JSON data, do
//
//     final result = resultFromJson(jsonString);

import 'dart:convert';

List<Result> resultFromJson(String str) =>
    List<Result>.from(json.decode(str).map((x) => Result.fromJson(x)));

String resultToJson(List<Result> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Result {
  String? nominationId;
  String? nominationText;
  double? score;

  Result({
    this.nominationId,
    this.nominationText,
    this.score,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        nominationId: json["nominationID"],
        nominationText: json["nominationText"],
        score: json["score"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "nominationID": nominationId,
        "nominationText": nominationText,
        "score": score,
      };
}
