// To parse this JSON data, do
//
//     final getNextLiangHua = getNextLiangHuaFromJson(jsonString);

import 'dart:convert';

GetNextLiangHua getNextLiangHuaFromJson(String str) => GetNextLiangHua.fromJson(json.decode(str));

String getNextLiangHuaToJson(GetNextLiangHua data) => json.encode(data.toJson());

class GetNextLiangHua {
  GetNextLiangHua({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  Data data;

  factory GetNextLiangHua.fromJson(Map<String, dynamic> json) => GetNextLiangHua(
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
    this.currentLevel,
    this.list,
  });

  Zonghe zonghe;
  String currentLevel;
  List<ListElement> list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    zonghe: json["zonghe"] == null ? null : Zonghe.fromJson(json["zonghe"]),
    currentLevel: json["currentLevel"] == null ? null : json["currentLevel"],
    list: json["list"] == null ? null : List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "zonghe": zonghe == null ? null : zonghe.toJson(),
    "currentLevel": currentLevel == null ? null : currentLevel,
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    this.teamName,
    this.planCount,
    this.finishCount,
    this.finishRate,
    this.nextLeader,
  });

  String teamName;
  int planCount;
  int finishCount;
  double finishRate;
  NextLeader nextLeader;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    teamName: json["teamName"] == null ? null : json["teamName"],
    planCount: json["planCount"] == null ? null : json["planCount"],
    finishCount: json["finishCount"] == null ? null : json["finishCount"],
    finishRate: json["finishRate"] == null ? null : json["finishRate"].toDouble(),
    nextLeader: json["nextLeader"] == null ? null : NextLeader.fromJson(json["nextLeader"]),
  );

  Map<String, dynamic> toJson() => {
    "teamName": teamName == null ? null : teamName,
    "planCount": planCount == null ? null : planCount,
    "finishCount": finishCount == null ? null : finishCount,
    "finishRate": finishRate == null ? null : finishRate,
    "nextLeader": nextLeader == null ? null : nextLeader.toJson(),
  };
}

class NextLeader {
  NextLeader({
    this.userPid,
    this.userName,
  });

  String userPid;
  String userName;

  factory NextLeader.fromJson(Map<String, dynamic> json) => NextLeader(
    userPid: json["UserPID"] == null ? null : json["UserPID"],
    userName: json["UserName"] == null ? null : json["UserName"],
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid == null ? null : userPid,
    "UserName": userName == null ? null : userName,
  };
}

class Zonghe {
  Zonghe({
    this.planCount,
    this.finishCount,
    this.finishRate,
  });

  int planCount;
  int finishCount;
  double finishRate;

  factory Zonghe.fromJson(Map<String, dynamic> json) => Zonghe(
    planCount: json["planCount"] == null ? null : json["planCount"],
    finishCount: json["finishCount"] == null ? null : json["finishCount"],
    finishRate: json["finishRate"] == null ? null : json["finishRate"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
  "planCount": planCount == null ? null : planCount,
  "finishCount": finishCount == null ? null : finishCount,
    "finishRate": finishRate == null ? null : finishRate,
  };
}