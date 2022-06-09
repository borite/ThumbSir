// To parse this JSON data, do
//
//     final userSelectMission = userSelectMissionFromJson(jsonString);

import 'dart:convert';

UserSelectMission userSelectMissionFromJson(String str) => UserSelectMission.fromJson(json.decode(str));

String userSelectMissionToJson(UserSelectMission data) => json.encode(data.toJson());

class UserSelectMission {
  UserSelectMission({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory UserSelectMission.fromJson(Map<String, dynamic> json) => UserSelectMission(
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
    required this.id,
    required this.companyId,
    required this.userId,
    required this.adminTaskId,
    this.planningStartTime,
    this.planningEndTime,
    this.addTime,
    required this.userLevel,
    required this.stars,
    required this.planningCount,
    required this.remark,
    required this.address,
    this.missionRecordLevel1,
    this.missionRecordLevel2,
    this.missionRecordLevel3,
    this.missionRecordLevel4,
    this.missionRecordLevel5,
    this.missionRecordLevel6,
    this.adminTask,
  });

  int id;
  String companyId;
  String userId;
  int adminTaskId;
  DateTime? planningStartTime;
  DateTime? planningEndTime;
  DateTime? addTime;
  int userLevel;
  int stars;
  int planningCount;
  String remark;
  String address;
  List<dynamic>? missionRecordLevel1;
  List<dynamic>? missionRecordLevel2;
  List<dynamic>? missionRecordLevel3;
  List<dynamic>? missionRecordLevel4;
  List<dynamic>? missionRecordLevel5;
  List<dynamic>? missionRecordLevel6;
  dynamic adminTask;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["ID"],
    companyId: json["CompanyID"],
    userId: json["UserID"],
    adminTaskId: json["AdminTaskID"],
    planningStartTime: json["PlanningStartTime"] == null ? null : DateTime.parse(json["PlanningStartTime"]),
    planningEndTime: json["PlanningEndTime"] == null ? null : DateTime.parse(json["PlanningEndTime"]),
    addTime: json["AddTime"] == null ? null : DateTime.parse(json["AddTime"]),
    userLevel: json["UserLevel"],
    stars: json["Stars"],
    planningCount: json["PlanningCount"],
    remark: json["Remark"],
    address: json["Address"],
    missionRecordLevel1: json["MissionRecord_Level1"] == null ? null : List<dynamic>.from(json["MissionRecord_Level1"].map((x) => x)),
    missionRecordLevel2: json["MissionRecord_Level2"] == null ? null : List<dynamic>.from(json["MissionRecord_Level2"].map((x) => x)),
    missionRecordLevel3: json["MissionRecord_Level3"] == null ? null : List<dynamic>.from(json["MissionRecord_Level3"].map((x) => x)),
    missionRecordLevel4: json["MissionRecord_Level4"] == null ? null : List<dynamic>.from(json["MissionRecord_Level4"].map((x) => x)),
    missionRecordLevel5: json["MissionRecord_Level5"] == null ? null : List<dynamic>.from(json["MissionRecord_Level5"].map((x) => x)),
    missionRecordLevel6: json["MissionRecord_Level6"] == null ? null : List<dynamic>.from(json["MissionRecord_Level6"].map((x) => x)),
    adminTask: json["AdminTask"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "CompanyID": companyId,
    "UserID": userId,
    "AdminTaskID": adminTaskId,
    "PlanningStartTime": planningStartTime == null ? null : planningStartTime!.toIso8601String(),
    "PlanningEndTime": planningEndTime == null ? null : planningEndTime!.toIso8601String(),
    "AddTime": addTime == null ? null : addTime!.toIso8601String(),
    "UserLevel": userLevel,
    "Stars": stars,
    "PlanningCount": planningCount,
    "Remark": remark,
    "Address": address,
    "MissionRecord_Level1": missionRecordLevel1 == null ? null : List<dynamic>.from(missionRecordLevel1!.map((x) => x)),
    "MissionRecord_Level2": missionRecordLevel2 == null ? null : List<dynamic>.from(missionRecordLevel2!.map((x) => x)),
    "MissionRecord_Level3": missionRecordLevel3 == null ? null : List<dynamic>.from(missionRecordLevel3!.map((x) => x)),
    "MissionRecord_Level4": missionRecordLevel4 == null ? null : List<dynamic>.from(missionRecordLevel4!.map((x) => x)),
    "MissionRecord_Level5": missionRecordLevel5 == null ? null : List<dynamic>.from(missionRecordLevel5!.map((x) => x)),
    "MissionRecord_Level6": missionRecordLevel6 == null ? null : List<dynamic>.from(missionRecordLevel6!.map((x) => x)),
    "AdminTask": adminTask,
  };
}