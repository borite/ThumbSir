// To parse this JSON data, do
//
//     final getNextLevelUsers = getNextLevelUsersFromJson(jsonString);

import 'dart:convert';

GetNextLevelUsers getNextLevelUsersFromJson(String str) => GetNextLevelUsers.fromJson(json.decode(str));

String getNextLevelUsersToJson(GetNextLevelUsers data) => json.encode(data.toJson());

class GetNextLevelUsers {
  GetNextLevelUsers({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum>? data;

  factory GetNextLevelUsers.fromJson(Map<String, dynamic> json) => GetNextLevelUsers(
    code: json["Code"],
    message: json["Message"],
    data: json["Data"] == null ? null : List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.userPid,
    required this.userLevel,
    required this.userName,
    this.headImg,
    required this.section,
    required this.phone,
    this.email,
    required this.isVip,
    this.vipEndTime,
  });

  String userPid;
  String userLevel;
  String userName;
  dynamic headImg;
  String section;
  String phone;
  dynamic email;
  bool isVip;
  dynamic vipEndTime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    userPid: json["UserPID"],
    userLevel: json["UserLevel"],
    userName: json["UserName"],
    headImg: json["HeadImg"],
    section: json["Section"],
    phone: json["Phone"],
    email: json["Email"],
    isVip: json["IsVIP"],
    vipEndTime: json["VipEndTime"],
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid,
    "UserLevel": userLevel,
    "UserName": userName,
    "HeadImg": headImg,
    "Section": section,
    "Phone": phone,
    "Email": email,
    "IsVIP": isVip,
    "VipEndTime": vipEndTime,
  };
}