// To parse this JSON data, do
//
//     final getMissionS = getMissionSFromJson(jsonString);

import 'dart:convert';

GetMissionS getMissionSFromJson(String str) => GetMissionS.fromJson(json.decode(str));

String getMissionSToJson(GetMissionS data) => json.encode(data.toJson());

class GetMissionS {
  GetMissionS({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum> data;

  factory GetMissionS.fromJson(Map<String, dynamic> json) => GetMissionS(
    code: json["Code"] == null ? null : json["Code"],
    message: json["Message"] == null ? null : json["Message"],
    data: json["Data"] == null ? null : List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Code": code == null ? null : code,
    "Message": message == null ? null : message,
    "Data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.taskTittleA,
    this.taskUnit,
    this.taskCountA,
  });

  int id;
  String taskTittleA;
  String taskUnit;
  int taskCountA;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["ID"] == null ? null : json["ID"],
    taskTittleA: json["TaskTittleA"] == null ? null : json["TaskTittleA"],
    taskUnit: json["TaskUnit"] == null ? null : json["TaskUnit"],
    taskCountA: json["TaskCountA"] == null ? null : json["TaskCountA"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id == null ? null : id,
    "TaskTittleA": taskTittleA == null ? null : taskTittleA,
    "TaskUnit": taskUnit == null ? null : taskUnit,
    "TaskCountA": taskCountA == null ? null : taskCountA,
  };
}