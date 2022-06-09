// To parse this JSON data, do
//
//     final sendVerifyCode = sendVerifyCodeFromJson(jsonString);

import 'dart:convert';

PhoneVerifyCode phoneVerifyCodeFromJson(String str) => PhoneVerifyCode.fromJson(json.decode(str));

String sendVerifyCodeToJson(PhoneVerifyCode data) => json.encode(data.toJson());

class PhoneVerifyCode {
  int code;
  String message;
  dynamic data;
  dynamic cookie;

  PhoneVerifyCode({
    required this.code,
    required this.message,
    required this.data,
    required this.cookie,
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
