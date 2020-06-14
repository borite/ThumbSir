// To parse this JSON data, do
//
//     final companyLevelList = companyLevelListFromJson(jsonString);

import 'dart:convert';

CompanyLevelList companyLevelListFromJson(String str) => CompanyLevelList.fromJson(json.decode(str));

String companyLevelListToJson(CompanyLevelList data) => json.encode(data.toJson());

class CompanyLevelList {
  CompanyLevelList({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  Datum data;

  factory CompanyLevelList.fromJson(Map<String, dynamic> json) => CompanyLevelList(
    code: json["Code"] == null ? null : json["Code"],
    message: json["Message"] == null ? null : json["Message"],
    data: json["Data"] == null ? null : Datum.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Code": code == null ? null : code,
    "Message": message == null ? null : message,
    "Data": data == null ? null : data.toJson(),
  };
}

class Datum {
  Datum({
    this.level1,
    this.level2,
    this.level3,
    this.level4,
    this.level5,
    this.level6,
  });

  String level1;
  String level2;
  String level3;
  String level4;
  String level5;
  String level6;

  factory Datum.fromJson(Map<String, dynamic> json) =>
      Datum(
        level1: json["level1"] == null ? null : json["level1"],
        level2: json["level2"] == null ? null : json["level2"],
        level3: json["level3"] == null ? null : json["level3"],
        level4: json["level4"] == null ? null : json["level4"],
        level5: json["level5"] == null ? null : json["level5"],
        level6: json["level6"] == null ? null : json["level6"],
      );

  Map<String, dynamic> toJson() =>
      {
        "level1": level1 == null ? null : level1,
        "level2": level2 == null ? null : level2,
        "level3": level3 == null ? null : level3,
        "level4": level4 == null ? null : level4,
        "level5": level5 == null ? null : level5,
        "level6": level6 == null ? null : level6,
      };
}