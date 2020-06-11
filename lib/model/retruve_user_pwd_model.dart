// To parse this JSON data, do
//
//     final sendVerifyCode = sendVerifyCodeFromJson(jsonString);

import 'dart:convert';

RetruveUserPwd RetruveUserPwdFromJson(String str) => RetruveUserPwd.fromJson(json.decode(str));

String RetruveUserPwdToJson(RetruveUserPwd data) => json.encode(data.toJson());

class RetruveUserPwd {
  int code;
  String message;
  String data;
  String cookie;

  RetruveUserPwd({
    this.code,
    this.message,
    this.data,
    this.cookie,
  });

  factory RetruveUserPwd.fromJson(Map<String, dynamic> json) => RetruveUserPwd(
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
