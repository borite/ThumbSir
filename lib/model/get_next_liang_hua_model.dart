// To parse this JSON data, do
//
//     final getNextLiangHua = getNextLiangHuaFromJson(jsonString);

import 'dart:convert';

GetNextLiangHua getNextLiangHuaFromJson(String str) => GetNextLiangHua.fromJson(json.decode(str));

String getNextLiangHuaToJson(GetNextLiangHua data) => json.encode(data.toJson());

class GetNextLiangHua {
  GetNextLiangHua({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory GetNextLiangHua.fromJson(Map<String, dynamic> json) => GetNextLiangHua(
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
    required this.currentLevel,
    this.list,
  });

  Zonghe? zonghe;
  String currentLevel;
  List<ListElement>? list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    zonghe: json["zonghe"] == null ? null : Zonghe.fromJson(json["zonghe"]),
    currentLevel: json["currentLevel"],
    list: json["list"] == null ? null : List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "zonghe": zonghe == null ? null : zonghe!.toJson(),
    "currentLevel": currentLevel,
    "list": list == null ? null : List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    required this.teamName,
    required this.planCount,
    required this.finishCount,
    required this.finishRate,
    this.nextLeader,
  });

  String teamName;
  int planCount;
  int finishCount;
  double finishRate;
  NextLeader? nextLeader;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    teamName: json["teamName"],
    planCount: json["planCount"],
    finishCount: json["finishCount"],
    finishRate: json["finishRate"].toDouble(),
    nextLeader: json["nextLeader"] == null ? null : NextLeader.fromJson(json["nextLeader"]),
  );

  Map<String, dynamic> toJson() => {
    "teamName": teamName,
    "planCount": planCount,
    "finishCount": finishCount,
    "finishRate": finishRate,
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
    userPid: json["UserPID"],
    userName: json["UserName"],
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid,
    "UserName": userName,
  };
}

class Zonghe {
  Zonghe({
    required this.planCount,
    required this.finishCount,
    required this.finishRate,
  });

  int planCount;
  int finishCount;
  double finishRate;

  factory Zonghe.fromJson(Map<String, dynamic> json) => Zonghe(
    planCount: json["planCount"],
    finishCount: json["finishCount"],
    finishRate: json["finishRate"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
  "planCount": planCount,
  "finishCount": finishCount,
    "finishRate": finishRate,
  };
}