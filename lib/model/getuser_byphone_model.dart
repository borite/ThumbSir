// To parse this JSON data, do
//
//     final getUserByPhone = getUserByPhoneFromJson(jsonString);

import 'dart:convert';

GetUserByPhone getUserByPhoneFromJson(String str) => GetUserByPhone.fromJson(json.decode(str));

String getUserByPhoneToJson(GetUserByPhone data) => json.encode(data.toJson());

class GetUserByPhone {
  GetUserByPhone({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  Data data;

  factory GetUserByPhone.fromJson(Map<String, dynamic> json) => GetUserByPhone(
    code: json["Code"] == null ? null : json["Code"],
    message: json["Message"] == null ? null : json["Message"],
    data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Code": code == null ? null : code,
    "Message": message == null ? null : message,
    "Data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.userPid,
    this.userName,
    this.userLevel,
    this.headImg,
    this.phone,
  });

  String userPid;
  String userName;
  String userLevel;
  String headImg;
  String phone;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userPid: json["UserPID"] == null ? null : json["UserPID"],
    userName: json["UserName"] == null ? null : json["UserName"],
    userLevel: json["UserLevel"] == null ? null : json["UserLevel"],
    headImg: json["HeadImg"] == null ? null : json["HeadImg"],
    phone: json["Phone"] == null ? null : json["Phone"],
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid == null ? null : userPid,
    "UserName": userName == null ? null : userName,
    "UserLevel": userLevel == null ? null : userLevel,
    "HeadImg": headImg == null ? null : headImg,
    "Phone": phone == null ? null : phone,
  };
}