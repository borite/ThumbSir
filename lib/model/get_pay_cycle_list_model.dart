// To parse this JSON data, do
//
//     final getPayCycleList = getPayCycleListFromJson(jsonString);

import 'dart:convert';

GetPayCycleList getPayCycleListFromJson(String str) => GetPayCycleList.fromJson(json.decode(str));

String getPayCycleListToJson(GetPayCycleList data) => json.encode(data.toJson());

class GetPayCycleList {
  GetPayCycleList({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum>? data;

  factory GetPayCycleList.fromJson(Map<String, dynamic> json) => GetPayCycleList(
    code: json["Code"],
    message: json["Message"],
    data: json["Data"] == null ? null : List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.cycleName,
    required this.cycleDays,
    required this.cycleRemark,
    required this.cycleState,
    required this.isFree,
  });

  int id;
  String cycleName;
  int cycleDays;
  String cycleRemark;
  int cycleState;
  bool isFree;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["ID"],
    cycleName: json["CycleName"],
    cycleDays: json["CycleDays"],
    cycleRemark: json["CycleRemark"],
    cycleState: json["CycleState"],
    isFree: json["IsFree"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "CycleName": cycleName,
    "CycleDays": cycleDays,
    "CycleRemark": cycleRemark,
    "CycleState": cycleState,
    "IsFree": isFree,
  };
}