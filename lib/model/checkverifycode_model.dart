// To parse this JSON data, do
//
//     final sendVerifyCode = sendVerifyCodeFromJson(jsonString);

import 'dart:convert';

CheckVerifyCode checkVerifyCodeFromJson(String str) => CheckVerifyCode.fromJson(json.decode(str));

String checkVerifyCodeToJson(CheckVerifyCode data) => json.encode(data.toJson());

class CheckVerifyCode {
  int code;
  String message;
  String data;
  String cookie;

  CheckVerifyCode({
    this.code,
    this.message,
    this.data,
    this.cookie,
  });

  factory CheckVerifyCode.fromJson(Map<String, dynamic> json) => CheckVerifyCode(
    code: json["Code"],
    message: json["Message"],
    data: json["Data"],
    cookie: json["Cookie"],
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": data,
    "Cookie": cookie,
  };
}
