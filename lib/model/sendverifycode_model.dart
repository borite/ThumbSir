import 'dart:convert';

SendVerifyCode sendVerifyCodeFromJson(String str) => SendVerifyCode.fromJson(json.decode(str));

String sendVerifyCodeToJson(SendVerifyCode data) => json.encode(data.toJson());

class SendVerifyCode {
  int code;
  String message;
  String data;

  SendVerifyCode({
    this.code,
    this.message,
    this.data,
  });

  factory SendVerifyCode.fromJson(Map<String, dynamic> json) => SendVerifyCode(
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