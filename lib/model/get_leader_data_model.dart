// To parse this JSON data, do
//
//     final getLeaderData = getLeaderDataFromJson(jsonString);

import 'dart:convert';

GetLeaderData getLeaderDataFromJson(String str) => GetLeaderData.fromJson(json.decode(str));

String getLeaderDataToJson(GetLeaderData data) => json.encode(data.toJson());

class GetLeaderData {
  GetLeaderData({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  Data data;

  factory GetLeaderData.fromJson(Map<String, dynamic> json) => GetLeaderData(
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
    this.leaderInfo,
    this.leaderCount,
  });

  LeaderInfo leaderInfo;
  LeaderCount leaderCount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    leaderInfo: json["leaderInfo"] == null ? null : LeaderInfo.fromJson(json["leaderInfo"]),
    leaderCount: json["leaderCount"] == null ? null : LeaderCount.fromJson(json["leaderCount"]),
  );

  Map<String, dynamic> toJson() => {
    "leaderInfo": leaderInfo == null ? null : leaderInfo.toJson(),
    "leaderCount": leaderCount == null ? null : leaderCount.toJson(),
  };
}

class LeaderCount {
  LeaderCount({
    this.planningCount,
    this.finishCount,
    this.finishRate,
  });

  int planningCount;
  int finishCount;
  double finishRate;

  factory LeaderCount.fromJson(Map<String, dynamic> json) => LeaderCount(
  planningCount: json["PlanningCount"] == null ? null : json["PlanningCount"],
  finishCount: json["FinishCount"] == null ? null : json["FinishCount"],
    finishRate: json["finishRate"] == null ? null : json["finishRate"],
  );

  Map<String, dynamic> toJson() => {
    "PlanningCount": planningCount == null ? null : planningCount,
    "FinishCount": finishCount == null ? null : finishCount,
    "finishRate": finishRate == null ? null : finishRate,
  };
}

class LeaderInfo {
  LeaderInfo({
    this.userName,
    this.userLevel,
    this.headImg,
  });

  String userName;
  String userLevel;
  dynamic headImg;

  factory LeaderInfo.fromJson(Map<String, dynamic> json) => LeaderInfo(
    userName: json["UserName"] == null ? null : json["UserName"],
    userLevel: json["UserLevel"] == null ? null : json["UserLevel"],
    headImg: json["HeadImg"],
  );

  Map<String, dynamic> toJson() => {
    "UserName": userName == null ? null : userName,
    "UserLevel": userLevel == null ? null : userLevel,
    "HeadImg": headImg,
  };
}