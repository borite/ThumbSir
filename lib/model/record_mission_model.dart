// To parse this JSON data, do
//
//     final recordMission = recordMissionFromJson(jsonString);

import 'dart:convert';

List<RecordMission> recordMissionFromJson(String str) => List<RecordMission>.from(json.decode(str).map((x) => RecordMission.fromJson(x)));

String recordMissionToJson(List<RecordMission> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecordMission {
  RecordMission({
    this.userLevels,
    this.userPid,
    this.img,
    this.phoneNum,
    this.selectMissionId,
    this.gpsLocation,
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
    "userLevels": userLevels == null ? null : userLevels,
    "UserPID": userPid == null ? null : userPid,
    "Img": img == null ? null : img,
    "PhoneNum": phoneNum == null ? null : phoneNum,
    "SelectMissionID": selectMissionId == null ? null : selectMissionId,
    "GpsLocation": gpsLocation == null ? null : gpsLocation,
  };
}