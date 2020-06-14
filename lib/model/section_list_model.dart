// To parse this JSON data, do
//
//     final sectionListModel = sectionListModelFromJson(jsonString);

import 'dart:convert';

SectionListModel sectionListModelFromJson(String str) => SectionListModel.fromJson(json.decode(str));

String sectionListModelToJson(SectionListModel data) => json.encode(data.toJson());

class SectionListModel {
  SectionListModel({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  List<String> data;

  factory SectionListModel.fromJson(Map<String, dynamic> json) => SectionListModel(
    code: json["Code"] == null ? null : json["Code"],
    message: json["Message"] == null ? null : json["Message"],
    data: json["Data"] == null ? null : List<String>.from(json["Data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Code": code == null ? null : code,
    "Message": message == null ? null : message,
    "Data": data == null ? null : List<dynamic>.from(data.map((x) => x)),
  };
}