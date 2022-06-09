// To parse this JSON data, do
//
//     final getUserByPhone = getUserByPhoneFromJson(jsonString);

import 'dart:convert';

GetUserByPhone getUserByPhoneFromJson(String str) => GetUserByPhone.fromJson(json.decode(str));

String getUserByPhoneToJson(GetUserByPhone data) => json.encode(data.toJson());

class GetUserByPhone {
  GetUserByPhone({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Data? data;

  factory GetUserByPhone.fromJson(Map<String, dynamic> json) => GetUserByPhone(
    code: json["Code"],
    message: json["Message"],
    data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    required this.userPid,
    required this.userName,
    required this.userLevel,
    required this.headImg,
    required this.phone,
  });

  String userPid;
  String userName;
  String userLevel;
  String? headImg;
  String phone;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userPid: json["UserPID"],
    userName: json["UserName"],
    userLevel: json["UserLevel"],
    headImg: json["HeadImg"],
    phone: json["Phone"],
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid,
    "UserName": userName,
    "UserLevel": userLevel,
    "HeadImg": headImg,
    "Phone": phone,
  };
}