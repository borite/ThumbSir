// To parse this JSON data, do
//
//     final getMissionRecord = getMissionRecordFromJson(jsonString);

import 'dart:convert';

GetMissionRecord getMissionRecordFromJson(String str) => GetMissionRecord.fromJson(json.decode(str));

String getMissionRecordToJson(GetMissionRecord data) => json.encode(data.toJson());

class GetMissionRecord {
    GetMissionRecord({
      required this.code,
      required this.message,
      this.data,
    });

      int code;
      String message;
      Data? data;

      factory GetMissionRecord.fromJson(Map<String, dynamic> json) => GetMissionRecord(
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
    this.missionImgs,
    this.address,
    this.submitTime,
    this.phoneNums,
  });

  String? missionImgs;
  String? address;
  DateTime? submitTime;
  String? phoneNums;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    missionImgs: json["MissionImgs"],
    address: json["Address"],
    submitTime: json["SubmitTime"] == null ? null : DateTime.parse(json["SubmitTime"]),
    phoneNums: json["PhoneNums"],
  );

  Map<String, dynamic> toJson() => {
    "MissionImgs": missionImgs,
    "Address": address,
    "SubmitTime": submitTime == null ? null : submitTime!.toIso8601String(),
    "PhoneNums": phoneNums,
  };
}