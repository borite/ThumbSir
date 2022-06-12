// To parse this JSON data, do
//
//     final getUserInfo = getUserInfoFromJson(jsonString);

import 'dart:convert';

GetUserInfo getUserInfoFromJson(String str) => GetUserInfo.fromJson(json.decode(str));

String getUserInfoToJson(GetUserInfo data) => json.encode(data.toJson());

class GetUserInfo {
  GetUserInfo({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum>? data;

  factory GetUserInfo.fromJson(Map<String, dynamic> json) => GetUserInfo(
    code: json["Code"] == null ? null : json["Code"],
    message: json["Message"] == null ? null : json["Message"],
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
    required this.userName,
    required this.userPid,
    required this.phone,
    this.isVip,
    this.vipEndTime,
    this.leaderName,
    required this.userState,
    required this.userLevel,
    this.headImg,
    required this.nextLevelCount,
    required this.companyName,
    required this.levelCount,
    required this.companyId,
    required this.region,
    required this.section,
    this.creatTime,
    required this.inviteCount,
    required this.sales,
    required this.cs,
  });

  String userName;
  String userPid;
  String phone;
  dynamic isVip;
  DateTime? vipEndTime;
  dynamic leaderName;
  int userState;
  String userLevel;
  dynamic headImg;
  int nextLevelCount;
  String companyName;
  int levelCount;
  String companyId;
  String region;
  String section;
  DateTime? creatTime;
  int inviteCount;
  String sales;
  String cs;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
  userName: json["UserName"] == null ? null : json["UserName"],
    userPid: json["UserPID"] == null ? null : json["UserPID"],
    phone: json["Phone"] == null ? null : json["Phone"],
    isVip: json["IsVIP"] == null ? null : json["IsVIP"],
    vipEndTime: json["VipEndTime"] == null ? null : DateTime.parse(json["VipEndTime"]),
    leaderName: json["leaderName"] == null ? null : json["leaderName"],
    userState: json["UserState"] == null ? null : json["UserState"],
    userLevel: json["UserLevel"] == null ? null : json["UserLevel"],
    headImg: json["HeadImg"] == null ? null : json["HeadImg"],
    nextLevelCount: json["NextLevelCount"] == null ? null : json["NextLevelCount"],
    companyName: json["CompanyName"] == null ? null : json["CompanyName"],
    levelCount: json["LevelCount"] == null ? null : json["LevelCount"],
    companyId: json["CompanyID"] == null ? null : json["CompanyID"],
    region: json["Region"] == null ? null : json["Region"],
    section: json["Section"] == null ? null : json["Section"],
    creatTime: json["CreatTime"] == null ? null : DateTime.parse(json["CreatTime"]),
    inviteCount: json["inviteCount"] == null ? null : json["inviteCount"],
    sales: json["sales"] == null ? null : json["sales"],
    cs: json["cs"] == null ? null : json["cs"],
  );

  Map<String, dynamic> toJson() => {
  "UserName": userName,
  "UserPID": userPid,
  "Phone": phone,
  "IsVIP": isVip == null ? null : isVip,
  "VipEndTime": vipEndTime == null ? null : vipEndTime!.toIso8601String(),
  "leaderName": leaderName == null ? null : leaderName,
  "UserState": userState,
  "UserLevel": userLevel,
  "HeadImg": headImg == null ? null : headImg,
  "NextLevelCount": nextLevelCount,
  "CompanyName": companyName,
    "LevelCount": levelCount,
    "CompanyID": companyId,
    "Region": region,
    "Section": section,
    "CreatTime": creatTime == null ? null : creatTime!.toIso8601String(),
    "inviteCount": inviteCount,
    "sales": sales,
    "cs": cs,
  };
}