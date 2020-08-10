// To parse this JSON data, do
//
//     final getMissionRecord = getMissionRecordFromJson(jsonString);

import 'dart:convert';

GetMissionRecord getMissionRecordFromJson(String str) => GetMissionRecord.fromJson(json.decode(str));

String getMissionRecordToJson(GetMissionRecord data) => json.encode(data.toJson());

class GetMissionRecord {
    GetMissionRecord({
      this.code,
      this.message,
      this.data,
    });

      int code;
      String message;
      Data data;

      factory GetMissionRecord.fromJson(Map<String, dynamic> json) => GetMissionRecord(
      code: json["Code"] == null ? null : json["Code"],
      message: json["Message"] == null ? null : json["Message"],
      data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
      );

      Map<String, dynamic> toJson() => {
      "Code": code == null ? null : code,
      "Message": message == null ? null : message,
      "Data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.missionImgs,
    this.address,
    this.submitTime,
    this.phoneNums,
  });

  String missionImgs;
  String address;
  DateTime submitTime;
  String phoneNums;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    missionImgs: json["MissionImgs"] == null ? null : json["MissionImgs"],
    address: json["Address"] == null ? null : json["Address"],
    submitTime: json["SubmitTime"] == null ? null : DateTime.parse(json["SubmitTime"]),
    phoneNums: json["PhoneNums"] == null ? null : json["PhoneNums"],
  );

  Map<String, dynamic> toJson() => {
    "MissionImgs": missionImgs == null ? null : missionImgs,
    "Address": address == null ? null : address,
    "SubmitTime": submitTime == null ? null : submitTime.toIso8601String(),
    "PhoneNums": phoneNums == null ? null : phoneNums,
  };
}