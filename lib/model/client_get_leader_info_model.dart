// To parse this JSON data, do
//
//     final clientGetLeaderInfo = clientGetLeaderInfoFromJson(jsonString);

import 'dart:convert';

ClientGetLeaderInfo clientGetLeaderInfoFromJson(String str) => ClientGetLeaderInfo.fromJson(json.decode(str));

String clientGetLeaderInfoToJson(ClientGetLeaderInfo data) => json.encode(data.toJson());

class ClientGetLeaderInfo {
  ClientGetLeaderInfo({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory ClientGetLeaderInfo.fromJson(Map<String, dynamic> json) => ClientGetLeaderInfo(
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
    this.levelLeaderData,
  });

  LeaderInfo? leaderInfo;
  LevelLeaderData? levelLeaderData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    leaderInfo: json["leaderInfo"] == null ? null : LeaderInfo.fromJson(json["leaderInfo"]),
    levelLeaderData: json["LevelLeaderData"] == null ? null : LevelLeaderData.fromJson(json["LevelLeaderData"]),
  );

  Map<String, dynamic> toJson() => {
    "leaderInfo": leaderInfo == null ? null : leaderInfo!.toJson(),
    "LevelLeaderData": levelLeaderData == null ? null : levelLeaderData!.toJson(),
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
  userName: json["UserName"] == null ? null : json["UserName"],
    userLevel: json["UserLevel"] == null ? null : json["UserLevel"],
    headImg: json["HeadImg"] == null ? null : json["HeadImg"],
    userPid: json["UserPID"] == null ? null : json["UserPID"],
  );

  Map<String, dynamic> toJson() => {
    "UserName": userName,
    "UserLevel": userLevel,
    "HeadImg": headImg == null ? null : headImg,
    "UserPID": userPid,
  };
}

class LevelLeaderData {
  LevelLeaderData({
    required this.yeZhuCount,
    required this.keHuCount,
    required this.duoXuQiuCount,
  });

  int yeZhuCount;
  int keHuCount;
  int duoXuQiuCount;

  factory LevelLeaderData.fromJson(Map<String, dynamic> json) => LevelLeaderData(
    yeZhuCount: json["YeZhuCount"] == null ? null : json["YeZhuCount"],
    keHuCount: json["KeHuCount"] == null ? null : json["KeHuCount"],
    duoXuQiuCount: json["DuoXuQiuCount"] == null ? null : json["DuoXuQiuCount"],
  );

  Map<String, dynamic> toJson() => {
    "YeZhuCount": yeZhuCount,
    "KeHuCount": keHuCount,
    "DuoXuQiuCount": duoXuQiuCount,
  };
}