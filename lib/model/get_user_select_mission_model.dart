// To parse this JSON data, do
//
//     final getUserSelectMission = getUserSelectMissionFromJson(jsonString);

import 'dart:convert';

GetUserSelectMission getUserSelectMissionFromJson(String str) => GetUserSelectMission.fromJson(json.decode(str));

String getUserSelectMissionToJson(GetUserSelectMission data) => json.encode(data.toJson());

class GetUserSelectMission {
  GetUserSelectMission({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum> data;

  factory GetUserSelectMission.fromJson(Map<String, dynamic> json) => GetUserSelectMission(
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
    this.taskName,
    this.taskeCount,
    this.taskUnit,
    this.stars,
    this.planningCount,
    this.planningStartTime,
    this.planningEndTime,
    this.finishCount,
    this.finishRate,
  });

  int id;
  String taskName;
  int taskeCount;
  String taskUnit;
  int stars;
  int planningCount;
  DateTime planningStartTime;
  DateTime planningEndTime;
  int finishCount;
  double finishRate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
  id: json["ID"] == null ? null : json["ID"],
  taskName: json["TaskName"] == null ? null : json["TaskName"],
  taskeCount: json["TaskeCount"] == null ? null : json["TaskeCount"],
  taskUnit: json["TaskUnit"] == null ? null : json["TaskUnit"],
  stars: json["Stars"] == null ? null : json["Stars"],
    planningCount: json["PlanningCount"] == null ? null : json["PlanningCount"],
    planningStartTime: json["PlanningStartTime"] == null ? null : DateTime.parse(json["PlanningStartTime"]),
    planningEndTime: json["PlanningEndTime"] == null ? null : DateTime.parse(json["PlanningEndTime"]),
    finishCount: json["finishCount"] == null ? null : json["finishCount"],
    finishRate: json["finishRate"] == null ? null : json["finishRate"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id == null ? null : id,
    "TaskName": taskName == null ? null : taskName,
    "TaskeCount": taskeCount == null ? null : taskeCount,
    "TaskUnit": taskUnit == null ? null : taskUnit,
    "Stars": stars == null ? null : stars,
    "PlanningCount": planningCount == null ? null : planningCount,
    "PlanningStartTime": planningStartTime == null ? null : planningStartTime.toIso8601String(),
    "PlanningEndTime": planningEndTime == null ? null : planningEndTime.toIso8601String(),
    "finishCount": finishCount == null ? null : finishCount,
    "finishRate": finishRate == null ? null : finishRate,
  };
}