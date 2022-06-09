// To parse this JSON data, do
//
//     final userReg = userRegFromJson(jsonString);

import 'dart:convert';

UserReg userRegFromJson(String str) => UserReg.fromJson(json.decode(str));

String userRegToJson(UserReg data) => json.encode(data.toJson());

class UserReg {
  int code;
  String message;
  dynamic data;

  UserReg({
    required this.code,
    required this.message,
    this.data,
  });

  factory UserReg.fromJson(Map<String, dynamic> json) => UserReg(
    code: json["Code"],
    message: json["Message"],
    data: json["Data"],
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": data,
  };
}
