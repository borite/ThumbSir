// To parse this JSON data, do
//
//     final sendVerifyCode = sendVerifyCodeFromJson(jsonString);

import 'dart:convert';

SendVerifyCode sendVerifyCodeFromJson(String str) => SendVerifyCode.fromJson(json.decode(str));

String sendVerifyCodeToJson(SendVerifyCode data) => json.encode(data.toJson());

class SendVerifyCode {
  int code;
  String message;
  dynamic data;
  dynamic cookie;

  SendVerifyCode({
    required this.code,
    required this.message,
    required this.data,
    required this.cookie,
  });

  factory SendVerifyCode.fromJson(Map<String, dynamic> json) => SendVerifyCode(
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
