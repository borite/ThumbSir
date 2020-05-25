// To parse this JSON data, do
//
//     final commonResult = commonResultFromJson(jsonString);

import 'dart:convert';

CommonResult commonResultFromJson(String str) => CommonResult.fromJson(json.decode(str));

String commonResultToJson(CommonResult data) => json.encode(data.toJson());

class CommonResult {
  int code;
  String message;
  String data;

  CommonResult({
    this.code,
    this.message,
    this.data,
  });

  factory CommonResult.fromJson(Map<String, dynamic> json) => CommonResult(
    code: json["Code"],
    message: json["Message"],
    data: json["Data"],
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": data,
  };
}