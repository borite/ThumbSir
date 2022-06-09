// To parse this JSON data, do
//
//     final getUserSelectMission = getUserSelectMissionFromJson(jsonString);

import 'dart:convert';

GetUserSelectMission getUserSelectMissionFromJson(String str) => GetUserSelectMission.fromJson(json.decode(str));

String getUserSelectMissionToJson(GetUserSelectMission data) => json.encode(data.toJson());

class GetUserSelectMission {
  GetUserSelectMission({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum>? data;

  factory GetUserSelectMission.fromJson(Map<String, dynamic> json) => GetUserSelectMission(
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
    required this.taskName,
    required this.taskUnit,
    required this.defaultTaskId,
    required this.stars,
    required this.planningCount,
    this.planningStartTime,
    this.planningEndTime,
    this.remark,
    this.address,
    required this.finishCount,
    required this.finishRate,
  });

  int id;
  String taskName;
  String taskUnit;
  int defaultTaskId;
  int stars;
  int planningCount;
  DateTime? planningStartTime;
  DateTime? planningEndTime;
  dynamic remark;
  dynamic address;
  int finishCount;
  double finishRate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
  id: json["ID"],
  taskName: json["TaskName"],
  taskUnit: json["TaskUnit"],
  defaultTaskId: json["DefaultTaskID"],
    stars: json["Stars"],
    planningCount: json["PlanningCount"],
    planningStartTime: json["PlanningStartTime"] == null ? null : DateTime.parse(json["PlanningStartTime"]),
    planningEndTime: json["PlanningEndTime"] == null ? null : DateTime.parse(json["PlanningEndTime"]),
    remark: json["Remark"],
    address: json["Address"],
    finishCount: json["finishCount"],
    finishRate: json["finishRate"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "TaskName": taskName,
    "TaskUnit": taskUnit,
    "DefaultTaskID": defaultTaskId,
    "Stars": stars,
    "PlanningCount": planningCount,
    "PlanningStartTime": planningStartTime == null ? null : planningStartTime!.toIso8601String(),
    "PlanningEndTime": planningEndTime == null ? null : planningEndTime!.toIso8601String(),
    "Remark": remark,
    "Address": address,
    "finishCount": finishCount,
    "finishRate": finishRate,
  };
}