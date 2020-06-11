// To parse this JSON data, do
//
//     final sendVerifyCode = sendVerifyCodeFromJson(jsonString);

import 'dart:convert';

GetUserByPhone getUserByPhoneFromJson(String str) => GetUserByPhone.fromJson(json.decode(str));

String getUserByPhoneToJson(GetUserByPhone data) => json.encode(data.toJson());

class GetUserByPhone {
  int code;
  String message;
  String data;
  String cookie;

  GetUserByPhone({
    this.code,
    this.message,
    this.data,
    this.cookie,
  });

  factory GetUserByPhone.fromJson(Map<String, dynamic> json) => GetUserByPhone(
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
