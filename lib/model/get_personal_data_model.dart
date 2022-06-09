// To parse this JSON data, do
//
//     final getPersonalData = getPersonalDataFromJson(jsonString);

import 'dart:convert';

GetPersonalData getPersonalDataFromJson(String str) => GetPersonalData.fromJson(json.decode(str));

String getPersonalDataToJson(GetPersonalData data) => json.encode(data.toJson());

class GetPersonalData {
  GetPersonalData({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory GetPersonalData.fromJson(Map<String, dynamic> json) => GetPersonalData(
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
    finishRate: json["finishRate"].toDouble(),
    taskName: json["TaskName"],
    taskUnit: json["TaskUnit"],
    defaultTaskId: json["DefaultTaskID"],
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
    required this.finishTask,
    required this.unFinishTask,
    required this.rate,
  });

  int planCount;
  int finishTask;
  int unFinishTask;
  double rate;

  factory Zonghe.fromJson(Map<String, dynamic> json) => Zonghe(
    planCount: json["planCount"],
    finishTask: json["finishTask"],
    unFinishTask: json["unFinishTask"],
    rate: json["rate"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "planCount": planCount,
    "finishTask": finishTask,
    "unFinishTask": unFinishTask,
    "rate": rate,
  };
}