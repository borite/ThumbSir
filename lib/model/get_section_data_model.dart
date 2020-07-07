// To parse this JSON data, do
//
//     final getSectionData = getSectionDataFromJson(jsonString);

import 'dart:convert';

GetSectionData getSectionDataFromJson(String str) => GetSectionData.fromJson(json.decode(str));

String getSectionDataToJson(GetSectionData data) => json.encode(data.toJson());

class GetSectionData {
  GetSectionData({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  Data data;

  factory GetSectionData.fromJson(Map<String, dynamic> json) => GetSectionData(
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
    this.planCount,
    this.finishCount,
    this.finishRate,
    this.taskName,
    this.taskUnit,
    this.defaultTaskId,
    this.timeProportion,
  });

  int planCount;
  int finishCount;
  double finishRate;
  String taskName;
  String taskUnit;
  int defaultTaskId;
  double timeProportion;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    planCount: json["planCount"] == null ? null : json["planCount"],
    finishCount: json["finishCount"] == null ? null : json["finishCount"],
    finishRate: json["finishRate"] == null ? null : json["finishRate"],
    taskName: json["TaskName"] == null ? null : json["TaskName"],
    taskUnit: json["TaskUnit"] == null ? null : json["TaskUnit"],
    defaultTaskId: json["DefaultTaskID"] == null ? null : json["DefaultTaskID"],
    timeProportion: json["timeProportion"] == null ? null : json["timeProportion"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "planCount": planCount == null ? null : planCount,
    "finishCount": finishCount == null ? null : finishCount,
    "finishRate": finishRate == null ? null : finishRate,
    "TaskName": taskName == null ? null : taskName,
    "TaskUnit": taskUnit == null ? null : taskUnit,
    "DefaultTaskID": defaultTaskId == null ? null : defaultTaskId,
    "timeProportion": timeProportion == null ? null : timeProportion,
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
    finishRate: json["finishRate"] == null ? null : json["finishRate"],
  );

  Map<String, dynamic> toJson() => {
    "planCount": planCount == null ? null : planCount,
    "finishCount": finishCount == null ? null : finishCount,
    "finishRate": finishRate == null ? null : finishRate,
  };
}