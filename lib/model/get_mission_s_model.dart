// To parse this JSON data, do
//
//     final getMissionS = getMissionSFromJson(jsonString);

import 'dart:convert';

GetMissionS getMissionSFromJson(String str) => GetMissionS.fromJson(json.decode(str));

String getMissionSToJson(GetMissionS data) => json.encode(data.toJson());

class GetMissionS {
  GetMissionS({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum>? data;

  factory GetMissionS.fromJson(Map<String, dynamic> json) => GetMissionS(
    code: json["Code"],
    message: json["Message"],
    data: json["Data"] == null ? null : List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.taskCount,
    required this.taskTitle,
    required this.taskUnit,
    required this.taskContent,
  });

  int id;
  int taskCount;
  String taskTitle;
  String taskUnit;
  String taskContent;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["ID"],
    taskCount: json["TaskCount"],
    taskTitle: json["TaskTitle"],
    taskUnit: json["TaskUnit"],
    taskContent: json["TaskContent"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "TaskCount": taskCount,
    "TaskTitle": taskTitle,
    "TaskUnit": taskUnit,
    "TaskContent": taskContent,
  };
}