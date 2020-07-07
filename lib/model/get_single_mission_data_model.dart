// To parse this JSON data, do
//
//     final getSingleMissionData = getSingleMissionDataFromJson(jsonString);

import 'dart:convert';

GetSingleMissionData getSingleMissionDataFromJson(String str) => GetSingleMissionData.fromJson(json.decode(str));

String getSingleMissionDataToJson(GetSingleMissionData data) => json.encode(data.toJson());

class GetSingleMissionData {
  GetSingleMissionData({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  Data data;

  factory GetSingleMissionData.fromJson(Map<String, dynamic> json) => GetSingleMissionData(
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

  List<Zonghe> zonghe;
  List<ListElement> list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    zonghe: json["zonghe"] == null ? null : List<Zonghe>.from(json["zonghe"].map((x) => Zonghe.fromJson(x))),
    list: json["list"] == null ? null : List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "zonghe": zonghe == null ? null : List<dynamic>.from(zonghe.map((x) => x.toJson())),
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    this.taskName,
    this.taskUnit,
    this.planCount,
    this.finishCount,
    this.finishRate,
    this.uinfo,
  });

  String taskName;
  String taskUnit;
  int planCount;
  int finishCount;
  double finishRate;
  List<Uinfo> uinfo;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    taskName: json["TaskName"] == null ? null : json["TaskName"],
    taskUnit: json["TaskUnit"] == null ? null : json["TaskUnit"],
    planCount: json["planCount"] == null ? null : json["planCount"],
    finishCount: json["finishCount"] == null ? null : json["finishCount"],
    finishRate: json["finishRate"] == null ? null : json["finishRate"].toDouble(),
    uinfo: json["uinfo"] == null ? null : List<Uinfo>.from(json["uinfo"].map((x) => Uinfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TaskName": taskName == null ? null : taskName,
    "TaskUnit": taskUnit == null ? null : taskUnit,
    "planCount": planCount == null ? null : planCount,
    "finishCount": finishCount == null ? null : finishCount,
    "finishRate": finishRate == null ? null : finishRate,
    "uinfo": uinfo == null ? null : List<dynamic>.from(uinfo.map((x) => x.toJson())),
  };
}

class Uinfo {
  Uinfo({
    this.userName,
    this.userLevel,
    this.headImg,
  });

  String userName;
  String userLevel;
  String headImg;

  factory Uinfo.fromJson(Map<String, dynamic> json) => Uinfo(
    userName: json["UserName"] == null ? null : json["UserName"],
    userLevel: json["UserLevel"] == null ? null : json["UserLevel"],
    headImg: json["HeadImg"] == null ? null : json["HeadImg"],
  );

  Map<String, dynamic> toJson() => {
    "UserName": userName == null ? null : userName,
    "UserLevel": userLevel == null ? null : userLevel,
    "HeadImg": headImg == null ? null : headImg,
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