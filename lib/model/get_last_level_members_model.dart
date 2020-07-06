// To parse this JSON data, do
//
//     final getLastLevelMembers = getLastLevelMembersFromJson(jsonString);

import 'dart:convert';

GetLastLevelMembers getLastLevelMembersFromJson(String str) => GetLastLevelMembers.fromJson(json.decode(str));

String getLastLevelMembersToJson(GetLastLevelMembers data) => json.encode(data.toJson());

class GetLastLevelMembers {
  GetLastLevelMembers({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  Data data;

  factory GetLastLevelMembers.fromJson(Map<String, dynamic> json) => GetLastLevelMembers(
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
    this.zonghe,
    this.list,
  });

  Zonghe zonghe;
  List<ListElement> list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    zonghe: json["zonghe"] == null ? null : Zonghe.fromJson(json["zonghe"]),
    list: json["list"] == null ? null : List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "zonghe": zonghe == null ? null : zonghe.toJson(),
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    this.userPid,
    this.userName,
    this.headImg,
    this.missionData,
  });

  String userPid;
  String userName;
  dynamic headImg;
  Zonghe missionData;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
  userPid: json["UserPID"] == null ? null : json["UserPID"],
  userName: json["UserName"] == null ? null : json["UserName"],
    headImg: json["HeadImg"],
    missionData: json["missionData"] == null ? null : Zonghe.fromJson(json["missionData"]),
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid == null ? null : userPid,
    "UserName": userName == null ? null : userName,
    "HeadImg": headImg,
    "missionData": missionData == null ? null : missionData.toJson(),
  };
}

class Zonghe {
  Zonghe({
    this.planningCount,
    this.finishCount,
    this.finishRate,
  });

  int planningCount;
  int finishCount;
  double finishRate;

  factory Zonghe.fromJson(Map<String, dynamic> json) => Zonghe(
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