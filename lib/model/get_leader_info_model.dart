// To parse this JSON data, do
//
//     final getLeaderInfo = getLeaderInfoFromJson(jsonString);

import 'dart:convert';

GetLeaderInfo getLeaderInfoFromJson(String str) => GetLeaderInfo.fromJson(json.decode(str));

String getLeaderInfoToJson(GetLeaderInfo data) => json.encode(data.toJson());

class GetLeaderInfo {
  GetLeaderInfo({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory GetLeaderInfo.fromJson(Map<String, dynamic> json) => GetLeaderInfo(
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
    this.leaderInfo,
    this.leaderCustomerCount,
  });

  LeaderInfo? leaderInfo;
  int? leaderCustomerCount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    leaderInfo: json["leaderInfo"] == null ? null : LeaderInfo.fromJson(json["leaderInfo"]),
    leaderCustomerCount: json["leaderCustomerCount"],
  );

  Map<String, dynamic> toJson() => {
    "leaderInfo": leaderInfo == null ? null : leaderInfo!.toJson(),
    "leaderCustomerCount": leaderCustomerCount,
  };
}

class LeaderInfo {
  LeaderInfo({
    required this.userName,
    required this.userLevel,
    required this.headImg,
    required this.userPid,
  });

  String userName;
  String userLevel;
  String headImg;
  String userPid;

  factory LeaderInfo.fromJson(Map<String, dynamic> json) => LeaderInfo(
  userName: json["UserName"],
  userLevel: json["UserLevel"],
    headImg: json["HeadImg"],
    userPid: json["UserPID"],
  );

  Map<String, dynamic> toJson() => {
    "UserName": userName,
    "UserLevel": userLevel,
    "HeadImg": headImg,
    "UserPID": userPid,
  };
}