// To parse this JSON data, do
//
//     final findUserResult = findUserResultFromJson(jsonString);

import 'dart:convert';

FindUserResult findUserResultFromJson(String str) => FindUserResult.fromJson(json.decode(str));

String findUserResultToJson(FindUserResult data) => json.encode(data.toJson());

class FindUserResult {
  FindUserResult({
    required this.code,
    required this.message,
    required this.data,
    required this.cookie,
  });

  int code;
  String message;
  Data? data;
  String? cookie;

  factory FindUserResult.fromJson(Map<String, dynamic> json) => FindUserResult(
    code: json["Code"],
    message: json["Message"],
    data: json["Data"],
    cookie: json["Cookie"]
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": data == null ? null : data!.toJson(),
    "Cookie": cookie,
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