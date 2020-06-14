// To parse this JSON data, do
//
//     final findUserResult = findUserResultFromJson(jsonString);

import 'dart:convert';

FindUserResult findUserResultFromJson(String str) => FindUserResult.fromJson(json.decode(str));

String findUserResultToJson(FindUserResult data) => json.encode(data.toJson());

class FindUserResult {
  FindUserResult({
    this.code,
    this.message,
    this.data,
    this.cookie,
  });

  int code;
  String message;
  Data data;
  String cookie;

  factory FindUserResult.fromJson(Map<String, dynamic> json) => FindUserResult(
    code: json["Code"] == null ? null : json["Code"],
    message: json["Message"] == null ? null : json["Message"],
    data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
    cookie: json["Cookie"]
  );

  Map<String, dynamic> toJson() => {
    "Code": code == null ? null : code,
    "Message": message == null ? null : message,
    "Data": data == null ? null : data.toJson(),
    "Cookie": cookie,
  };
}

class Data {
  Data({
    this.userPid,
    this.userName,
  });

  String userPid;
  String userName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userPid: json["UserPID"] == null ? null : json["UserPID"],
    userName: json["UserName"] == null ? null : json["UserName"],
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid == null ? null : userPid,
    "UserName": userName == null ? null : userName,
  };
}