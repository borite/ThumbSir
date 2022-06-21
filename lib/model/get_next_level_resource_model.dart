// To parse this JSON data, do
//
//     final getNextLevelHouseResource = getNextLevelHouseResourceFromJson(jsonString);

import 'dart:convert';

GetNextLevelHouseResource getNextLevelHouseResourceFromJson(String str) => GetNextLevelHouseResource.fromJson(json.decode(str));

String getNextLevelHouseResourceToJson(GetNextLevelHouseResource data) => json.encode(data.toJson());

class GetNextLevelHouseResource {
  GetNextLevelHouseResource({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory GetNextLevelHouseResource.fromJson(Map<String, dynamic> json) => GetNextLevelHouseResource(
    code: json["Code"],
    message: json["Message"],
    data: Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": data!.toJson(),
  };
}

class Data {
  Data({
    required this.userLevel,
    this.hids,
    required this.houseCount,
    this.teams,
  });

  String userLevel;
  dynamic hids;
  int houseCount;
  List<Team>? teams;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userLevel: json["userLevel"],
    hids: List<int>.from(json["hids"].map((x) => x)),
    houseCount: json["houseCount"],
    teams: List<Team>.from(json["teams"].map((x) => Team.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userLevel": userLevel,
    "hids": List<dynamic>.from(hids.map((x) => x)),
    "houseCount": houseCount,
    "teams": List<dynamic>.from(teams!.map((x) => x.toJson())),
  };
}

class Team {
  Team({
    this.teamName,
    this.leaderHouseCount,
    this.leaderName,
    this.leaderLevel,
    this.leaderHouseIDs,
    this.leaderHeadUrl,
    this.userId,
    this.areaIDs,
    this.areaHouseCount,
  });

  dynamic teamName;
  dynamic leaderHouseCount;
  dynamic leaderName;
  dynamic leaderLevel;
  dynamic leaderHouseIDs;
  dynamic leaderHeadUrl;
  dynamic userId;
  dynamic areaIDs;
  dynamic areaHouseCount;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    teamName: json["TeamName"],
    leaderHouseCount: json["LeaderHouseCount"],
    leaderName: json["LeaderName"],
    leaderLevel: json["LeaderLevel"],
    leaderHouseIDs: List<int>.from(json["LeaderHouseIDs"].map((x) => x)),
    leaderHeadUrl: json["LeaderHeadUrl"],
    userId: json["UserID"],
    areaIDs: List<int>.from(json["AreaIDs"].map((x) => x)),
    areaHouseCount: json["AreaHouseCount"],
  );

  Map<String, dynamic> toJson() => {
    "TeamName": teamName,
    "LeaderHouseCount": leaderHouseCount,
    "LeaderName": leaderName,
    "LeaderLevel": leaderLevel,
    "LeaderHouseIDs": List<dynamic>.from(leaderHouseIDs.map((x) => x)),
    "LeaderHeadUrl": leaderHeadUrl,
    "UserID": userId,
    "AreaIDs": List<dynamic>.from(areaIDs.map((x) => x)),
    "AreaHouseCount": areaHouseCount,
  };
}