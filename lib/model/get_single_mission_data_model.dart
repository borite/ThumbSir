// To parse this JSON data, do
//
//     final getSingleMissionData = getSingleMissionDataFromJson(jsonString);

import 'dart:convert';

GetSingleMissionData getSingleMissionDataFromJson(String str) => GetSingleMissionData.fromJson(json.decode(str));

String getSingleMissionDataToJson(GetSingleMissionData data) => json.encode(data.toJson());

class GetSingleMissionData {
  GetSingleMissionData({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory GetSingleMissionData.fromJson(Map<String, dynamic> json) => GetSingleMissionData(
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

  List<Zonghe>? zonghe;
  List<ListElement>? list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    zonghe: json["zonghe"] == null ? null : List<Zonghe>.from(json["zonghe"].map((x) => Zonghe.fromJson(x))),
    list: json["list"] == null ? null : List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "zonghe": zonghe == null ? null : List<dynamic>.from(zonghe!.map((x) => x.toJson())),
    "list": list == null ? null : List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    required this.taskName,
    required this.taskUnit,
    required this.planCount,
    required this.finishCount,
    required this.finishRate,
    this.uinfo,
  });

  String taskName;
  String taskUnit;
  int planCount;
  int finishCount;
  double finishRate;
  List<Uinfo>? uinfo;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    taskName: json["TaskName"],
    taskUnit: json["TaskUnit"],
    planCount: json["planCount"],
    finishCount: json["finishCount"],
    finishRate: json["finishRate"].toDouble(),
    uinfo: json["uinfo"] == null ? null : List<Uinfo>.from(json["uinfo"].map((x) => Uinfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TaskName": taskName,
    "TaskUnit": taskUnit,
    "planCount": planCount,
    "finishCount": finishCount,
    "finishRate": finishRate,
    "uinfo": uinfo == null ? null : List<dynamic>.from(uinfo!.map((x) => x.toJson())),
  };
}

class Uinfo {
  Uinfo({
    required this.userName,
    required this.userLevel,
    required this.headImg,
  });

  String userName;
  String userLevel;
  String headImg;

  factory Uinfo.fromJson(Map<String, dynamic> json) => Uinfo(
    userName: json["UserName"],
    userLevel: json["UserLevel"],
    headImg: json["HeadImg"],
  );

  Map<String, dynamic> toJson() => {
    "UserName": userName,
    "UserLevel": userLevel,
    "HeadImg": headImg,
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