// To parse this JSON data, do
//
//     final singInResult = singInResultFromJson(jsonString);

import 'dart:convert';

SingInResult singInResultFromJson(String str) => SingInResult.fromJson(json.decode(str));

String singInResultToJson(SingInResult data) => json.encode(data.toJson());

class SingInResult {
  SingInResult({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory SingInResult.fromJson(Map<String, dynamic> json) => SingInResult(
    code: json["Code"] == null ? null : json["Code"],
    message: json["Message"] == null ? null : json["Message"],
    data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": data == null ? null : data!.toJson(),
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
    userPid: json["UserPID"] == null ? null : json["UserPID"],
    userName: json["UserName"] == null ? null : json["UserName"],
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid,
    "UserName": userName,
  };
}