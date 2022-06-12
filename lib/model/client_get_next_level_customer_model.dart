// To parse this JSON data, do
//
//     final clientGetNextLevelCustomer = clientGetNextLevelCustomerFromJson(jsonString);

import 'dart:convert';

ClientGetNextLevelCustomer clientGetNextLevelCustomerFromJson(String str) => ClientGetNextLevelCustomer.fromJson(json.decode(str));

String clientGetNextLevelCustomerToJson(ClientGetNextLevelCustomer data) => json.encode(data.toJson());

class ClientGetNextLevelCustomer {
  ClientGetNextLevelCustomer({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory ClientGetNextLevelCustomer.fromJson(Map<String, dynamic> json) => ClientGetNextLevelCustomer(
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
    required this.currentLevel,
    this.levelData,
    this.list,
  });

  String currentLevel;
  LevelData? levelData;
  List<ListElement>? list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentLevel: json["currentLevel"] == null ? null : json["currentLevel"],
    levelData: json["levelData"] == null ? null : LevelData.fromJson(json["levelData"]),
    list: json["list"] == null ? null : List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "currentLevel": currentLevel,
    "levelData": levelData == null ? null : levelData!.toJson(),
    "list": list == null ? null : List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class LevelData {
  LevelData({
    required this.yeZhuCount,
    required this.keHuCount,
    required this.duoXuQiuCount,
  });

  int yeZhuCount;
  int keHuCount;
  int duoXuQiuCount;

  factory LevelData.fromJson(Map<String, dynamic> json) => LevelData(
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

class ListElement {
  ListElement({
    required this.teamName,
    this.levelData1,
    this.nextLeader,
  });

  String teamName;
  LevelData? levelData1;
  NextLeader? nextLeader;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    teamName: json["teamName"] == null ? null : json["teamName"],
    levelData1: json["levelData1"] == null ? null : LevelData.fromJson(json["levelData1"]),
    nextLeader: json["nextLeader"] == null ? null : NextLeader.fromJson(json["nextLeader"]),
  );

  Map<String, dynamic> toJson() => {
    "teamName": teamName,
    "levelData1": levelData1 == null ? null : levelData1!.toJson(),
    "nextLeader": nextLeader == null ? null : nextLeader!.toJson(),
  };
}

class NextLeader {
  NextLeader({
    required this.userPid,
    required this.userName,
  });

  String userPid;
  String userName;

  factory NextLeader.fromJson(Map<String, dynamic> json) => NextLeader(
    userPid: json["UserPID"] == null ? null : json["UserPID"],
    userName: json["UserName"] == null ? null : json["UserName"],
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid,
    "UserName": userName,
  };
}