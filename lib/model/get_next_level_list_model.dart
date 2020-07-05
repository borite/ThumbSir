// To parse this JSON data, do
//
//     final getNextLevelList = getNextLevelListFromJson(jsonString);

import 'dart:convert';

GetNextLevelList getNextLevelListFromJson(String str) => GetNextLevelList.fromJson(json.decode(str));

String getNextLevelListToJson(GetNextLevelList data) => json.encode(data.toJson());

class GetNextLevelList {
  GetNextLevelList({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  Data data;

  factory GetNextLevelList.fromJson(Map<String, dynamic> json) => GetNextLevelList(
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
    this.teamName,
    this.teamRate,
    this.nextLeaderId,
  });

  String teamName;
  int teamRate;
  String nextLeaderId;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    teamName: json["teamName"] == null ? null : json["teamName"],
    teamRate: json["teamRate"] == null ? null : json["teamRate"],
    nextLeaderId: json["nextLeaderID"] == null ? null : json["nextLeaderID"],
  );

  Map<String, dynamic> toJson() => {
    "teamName": teamName == null ? null : teamName,
    "teamRate": teamRate == null ? null : teamRate,
    "nextLeaderID": nextLeaderId == null ? null : nextLeaderId,
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
  int finishRate;

  factory Zonghe.fromJson(Map<String, dynamic> json) => Zonghe(
    planCount: json["planCount"] == null ? null : json["planCount"],
    finishCount: json["finishCount"] == null ? null : json["finishCount"],
    finishRate: json["finishRate"] == null ? null : json["finishRate"],
  );

  Map<String, dynamic> toJson() => {
    "planCount": planCount == null ? null : planCount,
    "finishCount": finishCount == null ? null : finishCount,
    "finishRate": finishRate == null ? null : finishRate,
  };
}