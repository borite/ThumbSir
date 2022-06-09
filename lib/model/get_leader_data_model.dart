// To parse this JSON data, do
//
//     final getLeaderData = getLeaderDataFromJson(jsonString);

import 'dart:convert';

GetLeaderData getLeaderDataFromJson(String str) => GetLeaderData.fromJson(json.decode(str));

String getLeaderDataToJson(GetLeaderData data) => json.encode(data.toJson());

class GetLeaderData {
  GetLeaderData({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory GetLeaderData.fromJson(Map<String, dynamic> json) => GetLeaderData(
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
    this.leaderInfo,
    this.leaderCount,
  });

  LeaderInfo? leaderInfo;
  LeaderCount? leaderCount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    leaderInfo: json["leaderInfo"] == null ? null : LeaderInfo.fromJson(json["leaderInfo"]),
    leaderCount: json["leaderCount"] == null ? null : LeaderCount.fromJson(json["leaderCount"]),
  );

  Map<String, dynamic> toJson() => {
    "leaderInfo": leaderInfo == null ? null : leaderInfo!.toJson(),
    "leaderCount": leaderCount == null ? null : leaderCount!.toJson(),
  };
}

class LeaderCount {
  LeaderCount({
    required this.planningCount,
    required this.finishCount,
    required this.finishRate,
  });

  int planningCount;
  int finishCount;
  double finishRate;

  factory LeaderCount.fromJson(Map<String, dynamic> json) => LeaderCount(
  planningCount: json["PlanningCount"],
  finishCount: json["FinishCount"],
    finishRate:json["finishRate"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "PlanningCount": planningCount,
    "FinishCount": finishCount,
    "finishRate": finishRate,
  };
}

class LeaderInfo {
  LeaderInfo({
    required this.userName,
    required this.userLevel,
    this.headImg,
    required this.userPid,
  });

  String userName;
  String userLevel;
  dynamic headImg;
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