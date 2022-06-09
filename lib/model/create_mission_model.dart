// To parse this JSON data, do
//final missionSubmit = missionSubmitFromJson(jsonString);

import 'dart:convert';

MissionSubmit missionSubmitFromJson(String str) => MissionSubmit.fromJson(json.decode(str));

String missionSubmitToJson(MissionSubmit data) => json.encode(data.toJson());

class MissionSubmit {
  MissionSubmit({
    required this.companyId,
    required this.userId,
    required this.selectTaskIDs,
    required this.minCount,
    required this.userLevel,
    this.missionContent,
  });

  String companyId;
  String userId;
  String selectTaskIDs;
  String minCount;
  String userLevel;
  List<MissionContent>? missionContent;

  factory MissionSubmit.fromJson(Map<String, dynamic> json) => MissionSubmit(
    companyId: json["CompanyID"] == null ? null : json["CompanyID"],
    userId: json["UserID"] == null ? null : json["UserID"],
    selectTaskIDs: json["SelectTaskIDs"] == null ? null : json["SelectTaskIDs"],
    minCount: json["MinCount"] == null ? null : json["MinCount"],
    userLevel: json["UserLevel"] == null ? null : json["UserLevel"],
    missionContent: json["MissionContent"] == null ? null : List<MissionContent>.from(json["MissionContent"].map((x) => MissionContent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "CompanyID": companyId,
    "UserID": userId,
    "SelectTaskIDs": selectTaskIDs,
    "MinCount": minCount,
    "UserLevel": userLevel,
    "MissionContent": missionContent == null ? null : List<dynamic>.from(missionContent!.map((x) => x.toJson())),
  };
}

class MissionContent {
  MissionContent({
    required this.id,
    required this.taskTitle,
    required this.taskUnit,
    required this.taskContent,
  });

  String id;
  String taskTitle;
  String taskUnit;
  String taskContent;

  factory MissionContent.fromJson(Map<String, dynamic> json) => MissionContent(
    id: json["ID"] == null ? null : json["ID"],
    taskTitle: json["TaskTitle"] == null ? null : json["TaskTitle"],
    taskUnit: json["TaskUnit"] == null ? null : json["TaskUnit"],
    taskContent: json["TaskContent"] == null ? null : json["TaskContent"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "TaskTitle": taskTitle,
    "TaskUnit": taskUnit,
    "TaskContent": taskContent,
  };
}
