// To parse this JSON data, do
//
//     final companyLevelList = companyLevelListFromJson(jsonString);

import 'dart:convert';

CompanyLevelList companyLevelListFromJson(String str) => CompanyLevelList.fromJson(json.decode(str));

String companyLevelListToJson(CompanyLevelList data) => json.encode(data.toJson());

class CompanyLevelList {
  CompanyLevelList({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Datum? data;

  factory CompanyLevelList.fromJson(Map<String, dynamic> json) => CompanyLevelList(
    code: json["Code"],
    message: json["Message"],
    data: json["Data"] == null ? null : Datum.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": data!.toJson(),
  };
}

class Datum {
  Datum({
    required this.level1,
    required this.level2,
    required this.level3,
    required this.level4,
    required this.level5,
    required this.level6,
  });

  String level1;
  String level2;
  String level3;
  String level4;
  String level5;
  String level6;

  factory Datum.fromJson(Map<String, dynamic> json) =>
      Datum(
        level1: json["level1"],
        level2: json["level2"],
        level3: json["level3"],
        level4: json["level4"],
        level5: json["level5"],
        level6: json["level6"],
      );

  Map<String, dynamic> toJson() =>
      {
        "level1": level1,
        "level2": level2,
        "level3": level3,
        "level4": level4,
        "level5": level5,
        "level6": level6,
      };
}