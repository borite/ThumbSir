// To parse this JSON data, do
//
//     final companyLevelList = companyLevelListFromJson(jsonString);

import 'dart:convert';

CompanyLevelList companyLevelListFromJson(String str) => CompanyLevelList.fromJson(json.decode(str));

String companyLevelListToJson(CompanyLevelList data) => json.encode(data.toJson());

class CompanyLevelList {
  int code;
  String message;
  List<Datum> data;

  CompanyLevelList({
    this.code,
    this.message,
    this.data,
  });

  factory CompanyLevelList.fromJson(Map<String, dynamic> json) => CompanyLevelList(
    code: json["Code"],
    message: json["Message"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String level1;
  String level2;
  String level3;
  String level4;
  String level5;
  String level6;

  Datum({
    this.level1,
    this.level2,
    this.level3,
    this.level4,
    this.level5,
    this.level6,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    level1: json["level1"],
    level2: json["level2"],
    level3: json["level3"],
    level4: json["level4"],
    level5: json["level5"],
    level6: json["level6"],
  );

  Map<String, dynamic> toJson() => {
    "level1": level1,
    "level2": level2,
    "level3": level3,
    "level4": level4,
    "level5": level5,
    "level6": level6,
  };
}
