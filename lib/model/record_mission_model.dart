// To parse this JSON data, do
//
//     final recordMission = recordMissionFromJson(jsonString);

import 'dart:convert';

List<RecordMission> recordMissionFromJson(String str) => List<RecordMission>.from(json.decode(str).map((x) => RecordMission.fromJson(x)));

String recordMissionToJson(List<RecordMission> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecordMission {
  RecordMission({
    required this.userLevels,
    required this.userPid,
    required this.img,
    required this.phoneNum,
    required this.selectMissionId,
    required this.gpsLocation,
  });

  String userLevels;
  String userPid;
  String img;
  String phoneNum;
  String selectMissionId;
  String gpsLocation;

  factory RecordMission.fromJson(Map<String, dynamic> json) => RecordMission(
    userLevels: json["userLevels"] == null ? null : json["userLevels"],
    userPid: json["UserPID"] == null ? null : json["UserPID"],
    img: json["Img"] == null ? null : json["Img"],
    phoneNum: json["PhoneNum"] == null ? null : json["PhoneNum"],
    selectMissionId: json["SelectMissionID"] == null ? null : json["SelectMissionID"],
    gpsLocation: json["GpsLocation"] == null ? null : json["GpsLocation"],
  );

  Map<String, dynamic> toJson() => {
    "userLevels": userLevels,
    "UserPID": userPid,
    "Img": img,
    "PhoneNum": phoneNum,
    "SelectMissionID": selectMissionId,
    "GpsLocation": gpsLocation,
  };
}