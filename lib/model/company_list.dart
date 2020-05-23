// To parse this JSON data, do
//
//     final companyList = companyListFromJson(jsonString);

import 'dart:convert';

CompanyList companyListFromJson(String str) => CompanyList.fromJson(json.decode(str));

String companyListToJson(CompanyList data) => json.encode(data.toJson());

class CompanyList {
  int code;
  String message;
  List<Datum> data;

  CompanyList({
    this.code,
    this.message,
    this.data,
  });

  factory CompanyList.fromJson(Map<String, dynamic> json) => CompanyList(
    code: json["Code"],
    message: json["Message"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String companyId;
  String companyName;

  Datum({
    this.companyId,
    this.companyName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    companyId: json["CompanyID"],
    companyName: json["CompanyName"],
  );

  Map<String, dynamic> toJson() => {
    "CompanyID": companyId,
    "CompanyName": companyName,
  };
}
