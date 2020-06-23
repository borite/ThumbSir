// To parse this JSON data, do
//
//     final getNextLevelUsers = getNextLevelUsersFromJson(jsonString);

import 'dart:convert';

GetNextLevelUsers getNextLevelUsersFromJson(String str) => GetNextLevelUsers.fromJson(json.decode(str));

String getNextLevelUsersToJson(GetNextLevelUsers data) => json.encode(data.toJson());

class GetNextLevelUsers {
  GetNextLevelUsers({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum> data;

  factory GetNextLevelUsers.fromJson(Map<String, dynamic> json) => GetNextLevelUsers(
    code: json["Code"] == null ? null : json["Code"],
    message: json["Message"] == null ? null : json["Message"],
    data: json["Data"] == null ? null : List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Code": code == null ? null : code,
    "Message": message == null ? null : message,
    "Data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.userPid,
    this.userLevel,
    this.userName,
    this.headImg,
    this.section,
    this.phone,
    this.email,
    this.isVip,
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
    userPid: json["UserPID"] == null ? null : json["UserPID"],
    userLevel: json["UserLevel"] == null ? null : json["UserLevel"],
    userName: json["UserName"] == null ? null : json["UserName"],
    headImg: json["HeadImg"],
    section: json["Section"] == null ? null : json["Section"],
    phone: json["Phone"] == null ? null : json["Phone"],
    email: json["Email"],
    isVip: json["IsVIP"] == null ? null : json["IsVIP"],
    vipEndTime: json["VipEndTime"],
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid == null ? null : userPid,
    "UserLevel": userLevel == null ? null : userLevel,
    "UserName": userName == null ? null : userName,
    "HeadImg": headImg,
    "Section": section == null ? null : section,
    "Phone": phone == null ? null : phone,
    "Email": email,
    "IsVIP": isVip == null ? null : isVip,
    "VipEndTime": vipEndTime,
  };
}