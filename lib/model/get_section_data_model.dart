// To parse this JSON data, do
//
//     final getSectionData = getSectionDataFromJson(jsonString);

import 'dart:convert';

GetSectionData getSectionDataFromJson(String str) => GetSectionData.fromJson(json.decode(str));

String getSectionDataToJson(GetSectionData data) => json.encode(data.toJson());

class GetSectionData {
  GetSectionData({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory GetSectionData.fromJson(Map<String, dynamic> json) => GetSectionData(
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
    required this.planCount,
    required this.finishCount,
    required this.finishRate,
    required this.taskName,
    required this.taskUnit,
    required this.defaultTaskId,
    required this.timeProportion,
  });

  int planCount;
  int finishCount;
  double finishRate;
  String taskName;
  String taskUnit;
  int defaultTaskId;
  double timeProportion;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    planCount: json["planCount"],
    finishCount: json["finishCount"],
    finishRate: json["finishRate"],
    taskName: json["TaskName"],
    taskUnit: json["TaskUnit"],
    defaultTaskId: json["DefaultTaskID"] ,
    timeProportion: json["timeProportion"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "planCount": planCount,
    "finishCount": finishCount,
    "finishRate": finishRate,
    "TaskName": taskName,
    "TaskUnit": taskUnit,
    "DefaultTaskID": defaultTaskId,
    "timeProportion": timeProportion,
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
    finishRate: json["finishRate"],
  );

  Map<String, dynamic> toJson() => {
    "planCount": planCount,
    "finishCount": finishCount,
    "finishRate": finishRate,
  };
}