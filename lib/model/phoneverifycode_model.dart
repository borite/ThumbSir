// To parse this JSON data, do
//
//     final sendVerifyCode = sendVerifyCodeFromJson(jsonString);

import 'dart:convert';

PhoneVerifyCode phoneVerifyCodeFromJson(String str) => PhoneVerifyCode.fromJson(json.decode(str));

String sendVerifyCodeToJson(PhoneVerifyCode data) => json.encode(data.toJson());

class PhoneVerifyCode {
  int code;
  String message;
  String data;
  String cookie;

  PhoneVerifyCode({
    this.code,
    this.message,
    this.data,
    this.cookie,
  });

  factory PhoneVerifyCode.fromJson(Map<String, dynamic> json) => PhoneVerifyCode(
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
