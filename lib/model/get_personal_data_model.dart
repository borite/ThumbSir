// To parse this JSON data, do
//
//     final getPersonalData = getPersonalDataFromJson(jsonString);

import 'dart:convert';

GetPersonalData getPersonalDataFromJson(String str) => GetPersonalData.fromJson(json.decode(str));

String getPersonalDataToJson(GetPersonalData data) => json.encode(data.toJson());

class GetPersonalData {
  GetPersonalData({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  Data data;

  factory GetPersonalData.fromJson(Map<String, dynamic> json) => GetPersonalData(
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
    finishRate: json["finishRate"] == null ? null : json["finishRate"].toDouble(),
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
    this.finishTask,
    this.unFinishTask,
    this.rate,
  });

  int planCount;
  int finishTask;
  int unFinishTask;
  double rate;

  factory Zonghe.fromJson(Map<String, dynamic> json) => Zonghe(
    planCount: json["planCount"] == null ? null : json["planCount"],
    finishTask: json["finishTask"] == null ? null : json["finishTask"],
    unFinishTask: json["unFinishTask"] == null ? null : json["unFinishTask"],
    rate: json["rate"] == null ? null : json["rate"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "planCount": planCount == null ? null : planCount,
    "finishTask": finishTask == null ? null : finishTask,
    "unFinishTask": unFinishTask == null ? null : unFinishTask,
    "rate": rate == null ? null : rate,
  };
}