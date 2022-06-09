// To parse this JSON data, do
//
//     final modifyPreCheck402 = modifyPreCheck402FromJson(jsonString);

import 'dart:convert';

ModifyPreCheck402 modifyPreCheck402FromJson(String str) => ModifyPreCheck402.fromJson(json.decode(str));

String modifyPreCheck402ToJson(ModifyPreCheck402 data) => json.encode(data.toJson());

class ModifyPreCheck402 {
  ModifyPreCheck402({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory ModifyPreCheck402.fromJson(Map<String, dynamic> json) => ModifyPreCheck402(
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
    this.delPlans,
    this.modiPlans,
  });

  List<Plan>? delPlans;
  List<Plan>? modiPlans;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    delPlans: json["delPlans"] == null ? null : List<Plan>.from(json["delPlans"].map((x) => Plan.fromJson(x))),
    modiPlans: json["modiPlans"] == null ? null : List<Plan>.from(json["modiPlans"].map((x) => Plan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "delPlans": delPlans == null ? null : List<dynamic>.from(delPlans!.map((x) => x.toJson())),
    "modiPlans": modiPlans == null ? null : List<dynamic>.from(modiPlans!.map((x) => x.toJson())),
  };
}

class Plan {
  Plan({
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

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    planningStartTime: json["PlanningStartTime"] == null ? null : DateTime.parse(json["PlanningStartTime"]),
    defaultTaskId: json["DefaultTaskID"],
    planningEndTime: json["PlanningEndTime"] == null ? null : DateTime.parse(json["PlanningEndTime"]),
    id: json["ID"],
    taskName: json["TaskName"],
    companyId: json["CompanyID"],
    userId: json["UserID"],
    userLevel: json["UserLevel"],
    stars: json["Stars"],
    planningCount: json["PlanningCount"],
    address: json["Address"],
    remark: json["Remark"],
    isKpi: json["IsKPI"],
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
