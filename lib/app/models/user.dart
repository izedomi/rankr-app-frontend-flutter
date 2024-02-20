// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? pollId;
  String? name;
  int? iat;
  int? exp;
  String? sub;

  User({
    this.pollId,
    this.name,
    this.iat,
    this.exp,
    this.sub,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        pollId: json["pollID"],
        name: json["name"],
        iat: json["iat"],
        exp: json["exp"],
        sub: json["sub"],
      );

  Map<String, dynamic> toJson() => {
        "pollID": pollId,
        "name": name,
        "iat": iat,
        "exp": exp,
        "sub": sub,
      };
}
