// To parse this JSON data, do
//final missionSubmit = missionSubmitFromJson(jsonString);

import 'dart:convert';

MissionSubmit missionSubmitFromJson(String str) => MissionSubmit.fromJson(json.decode(str));

String missionSubmitToJson(MissionSubmit data) => json.encode(data.toJson());

class MissionSubmit {
  MissionSubmit({
    this.companyId,
    this.userId,
    this.selectTaskIDs,
    this.minCount,
    this.userLevel,
    this.missionContent,
  });

  String companyId;
  String userId;
  String selectTaskIDs;
  String minCount;
  String userLevel;
  List<MissionContent> missionContent;

  factory MissionSubmit.fromJson(Map<String, dynamic> json) => MissionSubmit(
    companyId: json["CompanyID"] == null ? null : json["CompanyID"],
    userId: json["UserID"] == null ? null : json["UserID"],
    selectTaskIDs: json["SelectTaskIDs"] == null ? null : json["SelectTaskIDs"],
    minCount: json["MinCount"] == null ? null : json["MinCount"],
    userLevel: json["UserLevel"] == null ? null : json["UserLevel"],
    missionContent: json["MissionContent"] == null ? null : List<MissionContent>.from(json["MissionContent"].map((x) => MissionContent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "CompanyID": companyId == null ? null : companyId,
    "UserID": userId == null ? null : userId,
    "SelectTaskIDs": selectTaskIDs == null ? null : selectTaskIDs,
    "MinCount": minCount == null ? null : minCount,
    "UserLevel": userLevel == null ? null : userLevel,
    "MissionContent": missionContent == null ? null : List<dynamic>.from(missionContent.map((x) => x.toJson())),
  };
}

class MissionContent {
  MissionContent({
    this.id,
    this.taskTitle,
    this.taskUnit,
    this.taskContent,
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
    "ID": id == null ? null : id,
    "TaskTitle": taskTitle == null ? null : taskTitle,
    "TaskUnit": taskUnit == null ? null : taskUnit,
    "TaskContent": taskContent == null ? null : taskContent,
  };
}
