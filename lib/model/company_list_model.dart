// To parse this JSON data, do
//
//     final companylList = companylListFromJson(jsonString);

import 'dart:convert';

CompanyList companyListFromJson(String str) => CompanyList.fromJson(json.decode(str));

String companyListToJson(CompanyList data) => json.encode(data.toJson());

class CompanyList {
  CompanyList({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  List<Datum>? data;

  factory CompanyList.fromJson(Map<String, dynamic> json) => CompanyList(
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
    required this.companyId,
    required this.companyName,
    required this.levelCount,
  });

  String companyId;
  String companyName;
  int levelCount;

  @override
  String toString() => companyName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    companyId: json["CompanyID"],
    companyName: json["CompanyName"],
    levelCount: json["LevelCount"],
  );

  Map<String, dynamic> toJson() => {
    "CompanyID": companyId,
    "CompanyName": companyName,
    "LevelCount": levelCount,
  };
}