// To parse this JSON data, do
//
//     final companylList = companylListFromJson(jsonString);

import 'dart:convert';

CompanyList companyListFromJson(String str) => CompanyList.fromJson(json.decode(str));

String companyListToJson(CompanyList data) => json.encode(data.toJson());

class CompanyList {
  CompanyList({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum> data;

  factory CompanyList.fromJson(Map<String, dynamic> json) => CompanyList(
    code: json["Code"] == null ? null : json["Code"],
    message: json["Message"] == null ? null : json["Message"],
    data: json["Data"] == null ? null : List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Code": code == null ? null : code,
    "Message": message == null ? null : message,
    "Data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.companyId,
    this.companyName,
    this.levelCount,
  });

  String companyId;
  String companyName;
  int levelCount;

  @override
  String toString() => companyName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    companyId: json["CompanyID"] == null ? null : json["CompanyID"],
    companyName: json["CompanyName"] == null ? null : json["CompanyName"],
    levelCount: json["LevelCount"] == null ? null : json["LevelCount"],
  );

  Map<String, dynamic> toJson() => {
    "CompanyID": companyId == null ? null : companyId,
    "CompanyName": companyName == null ? null : companyName,
    "LevelCount": levelCount == null ? null : levelCount,
  };
}