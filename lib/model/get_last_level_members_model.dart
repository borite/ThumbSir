// To parse this JSON data, do
//
//     final getLastLevelMembers = getLastLevelMembersFromJson(jsonString);

import 'dart:convert';

GetLastLevelMembers getLastLevelMembersFromJson(String str) => GetLastLevelMembers.fromJson(json.decode(str));

String getLastLevelMembersToJson(GetLastLevelMembers data) => json.encode(data.toJson());

class GetLastLevelMembers {
  GetLastLevelMembers({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory GetLastLevelMembers.fromJson(Map<String, dynamic> json) => GetLastLevelMembers(
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
    this.zonghe,
    this.list,
  });

  Zonghe? zonghe;
  List<ListElement>? list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    zonghe: json["zonghe"] == null ? null : Zonghe.fromJson(json["zonghe"]),
    list: json["list"] == null ? null : List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "zonghe": zonghe == null ? null : zonghe!.toJson(),
    "list": list == null ? null : List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    required this.userPid,
    required this.userName,
    this.headImg,
    required this.userLevel,
    this.missionData,
  });

  String userPid;
  String userName;
  dynamic headImg;
  String userLevel;
  Zonghe? missionData;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
  userPid: json["UserPID"],
    userName: json["UserName"],
    headImg: json["HeadImg"],
    userLevel: json["UserLevel"],
    missionData: json["missionData"] == null ? null : Zonghe.fromJson(json["missionData"]),
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid,
    "UserName": userName,
    "HeadImg": headImg,
    "UserLevel": userLevel,
    "missionData": missionData == null ? null : missionData!.toJson(),
  };
}

class Zonghe {
  Zonghe({
    required this.planningCount,
    required this.finishCount,
    required this.finishRate,
  });

  int planningCount;
  int finishCount;
  double finishRate;

  factory Zonghe.fromJson(Map<String, dynamic> json) => Zonghe(
    planningCount: json["PlanningCount"],
    finishCount: json["FinishCount"],
    finishRate: json["finishRate"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "PlanningCount": planningCount,
    "FinishCount": finishCount,
    "finishRate": finishRate,
  };
}