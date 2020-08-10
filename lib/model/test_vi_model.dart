// To parse this JSON data, do
//
//     final testVi = testViFromJson(jsonString);

import 'dart:convert';

TestVi testViFromJson(String str) => TestVi.fromJson(json.decode(str));

String testViToJson(TestVi data) => json.encode(data.toJson());

class TestVi {
  TestVi({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  String data;

  factory TestVi.fromJson(Map<String, dynamic> json) => TestVi(
    code: json["Code"] == null ? null : json["Code"],
    message: json["Message"] == null ? null : json["Message"],
    data: json["Data"] == null ? null : json["Data"],
  );

  Map<String, dynamic> toJson() => {
    "Code": code == null ? null : code,
    "Message": message == null ? null : message,
    "Data": data == null ? null : data,
  };
}