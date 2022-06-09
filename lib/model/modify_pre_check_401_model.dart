// To parse this JSON data, do
//
//     final modifyPreCheck401 = modifyPreCheck401FromJson(jsonString);

import 'dart:convert';

ModifyPreCheck401 modifyPreCheck401FromJson(String str) => ModifyPreCheck401.fromJson(json.decode(str));

String modifyPreCheck401ToJson(ModifyPreCheck401 data) => json.encode(data.toJson());

class ModifyPreCheck401 {
  ModifyPreCheck401({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory ModifyPreCheck401.fromJson(Map<String, dynamic> json) => ModifyPreCheck401(
    code: json["Code"] == null ? null : json["Code"],
    message: json["Message"] == null ? null : json["Message"],
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
    this.delPlans,
    this.modiPlans,
  });

  Plans? delPlans;
  Plans? modiPlans;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    delPlans: json["delPlans"] == null ? null : Plans.fromJson(json["delPlans"]),
    modiPlans: json["modiPlans"] == null ? null : Plans.fromJson(json["modiPlans"]),
  );

  Map<String, dynamic> toJson() => {
    "delPlans": delPlans == null ? null : delPlans!.toJson(),
    "modiPlans": modiPlans == null ? null : modiPlans!.toJson(),
  };
}

class Plans {
  Plans({
    this.planningStartTime,
    required this.defaultTaskId,
    this.planningEndTime,
    required this.id,
    required this.taskName,
    required this.companyId,
    required this.userId,
    required this.userLevel,
    required this.stars,
    required this.planningCount,
    this.address,
    this.remark,
    required this.isKpi,
  });

  DateTime? planningStartTime;
  int defaultTaskId;
  DateTime? planningEndTime;
  int id;
  String taskName;
  String companyId;
  String userId;
  int userLevel;
  int stars;
  int planningCount;
  dynamic address;
  dynamic remark;
  bool isKpi;

  factory Plans.fromJson(Map<String, dynamic> json) => Plans(
    planningStartTime: json["PlanningStartTime"] == null ? null : DateTime.parse(json["PlanningStartTime"]),
    defaultTaskId: json["DefaultTaskID"] == null ? null : json["DefaultTaskID"],
    planningEndTime: json["PlanningEndTime"] == null ? null : DateTime.parse(json["PlanningEndTime"]),
    id: json["ID"] == null ? null : json["ID"],
    taskName: json["TaskName"] == null ? null : json["TaskName"],
    companyId: json["CompanyID"] == null ? null : json["CompanyID"],
    userId: json["UserID"] == null ? null : json["UserID"],
    userLevel: json["UserLevel"] == null ? null : json["UserLevel"],
    stars: json["Stars"] == null ? null : json["Stars"],
    planningCount: json["PlanningCount"] == null ? null : json["PlanningCount"],
    address: json["Address"],
    remark: json["Remark"],
    isKpi: json["IsKPI"] == null ? null : json["IsKPI"],
  );

  Map<String, dynamic> toJson() => {
    "PlanningStartTime": planningStartTime == null ? null : planningStartTime!.toIso8601String(),
    "DefaultTaskID": defaultTaskId,
    "PlanningEndTime": planningEndTime == null ? null : planningEndTime!.toIso8601String(),
    "ID": id,
    "TaskName": taskName,
    "CompanyID": companyId,
    "UserID": userId,
    "UserLevel": userLevel,
    "Stars": stars,
    "PlanningCount": planningCount,
    "Address": address,
    "Remark": remark,
    "IsKPI": isKpi,
  };
}