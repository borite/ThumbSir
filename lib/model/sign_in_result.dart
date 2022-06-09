// To parse this JSON data, do
//
//     final singInResult = singInResultFromJson(jsonString);

import 'dart:convert';

SingInResult signInResultFromJson(String str) => SingInResult.fromJson(json.decode(str));

String singInResultToJson(SingInResult data) => json.encode(data.toJson());

class SingInResult {
  SingInResult({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Data? data;

  factory SingInResult.fromJson(Map<String, dynamic> json) => SingInResult(
    code: json["Code"],
    message: json["Message"],
    data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": data?.toJson(),
  };
}

class Data {
  Data({
    required this.userPid,
    required this.userName,
  });

  String userPid;
  String userName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userPid: json["UserPID"],
    userName: json["UserName"],
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid,
    "UserName": userName,
  };
}