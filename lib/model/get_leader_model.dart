// To parse this JSON data, do
//
//     final getLeader = getLeaderFromJson(jsonString);

import 'dart:convert';

GetLeader getLeaderFromJson(String str) => GetLeader.fromJson(json.decode(str));

String getLeaderToJson(GetLeader data) => json.encode(data.toJson());

class GetLeader {
  GetLeader({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  Data data;

  factory GetLeader.fromJson(Map<String, dynamic> json) => GetLeader(
    code: json["Code"] == null ? null : json["Code"],
    message: json["Message"] == null ? null : json["Message"],
    data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Code": code == null ? null : code,
    "Message": message == null ? null : message,
    "Data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.userPid,
    this.userName,
    this.headImg,
    this.phone,
    this.userLevel,
  });

  String userPid;
  String userName;
  dynamic headImg;
  String phone;
  String userLevel;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userPid: json["UserPID"] == null ? null : json["UserPID"],
    userName: json["UserName"] == null ? null : json["UserName"],
    headImg: json["HeadImg"],
    phone: json["Phone"] == null ? null : json["Phone"],
    userLevel: json["UserLevel"] == null ? null : json["UserLevel"],
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid == null ? null : userPid,
    "UserName": userName == null ? null : userName,
    "HeadImg": headImg,
    "Phone": phone == null ? null : phone,
    "UserLevel": userLevel == null ? null : userLevel,
  };
}