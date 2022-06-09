// To parse this JSON data, do
//
//     final getLeader = getLeaderFromJson(jsonString);

import 'dart:convert';

GetLeader getLeaderFromJson(String str) => GetLeader.fromJson(json.decode(str));

String getLeaderToJson(GetLeader data) => json.encode(data.toJson());

class GetLeader {
  GetLeader({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Data? data;

  factory GetLeader.fromJson(Map<String, dynamic> json) => GetLeader(
    code: json["Code"],
    message: json["Message"],
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
    this.headImg,
    required this.phone,
    required this.userLevel,
  });

  String userPid;
  String userName;
  dynamic headImg;
  String phone;
  String userLevel;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userPid: json["UserPID"],
    userName: json["UserName"],
    headImg: json["HeadImg"],
    phone: json["Phone"],
    userLevel: json["UserLevel"],
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid,
    "UserName": userName,
    "HeadImg": headImg,
    "Phone": phone,
    "UserLevel": userLevel,
  };
}