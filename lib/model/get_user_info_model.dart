// To parse this JSON data, do
//
//     final getUserInfo = getUserInfoFromJson(jsonString);

import 'dart:convert';

GetUserInfo getUserInfoFromJson(String str) => GetUserInfo.fromJson(json.decode(str));

String getUserInfoToJson(GetUserInfo data) => json.encode(data.toJson());

class GetUserInfo {
  GetUserInfo({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum> data;

  factory GetUserInfo.fromJson(Map<String, dynamic> json) => GetUserInfo(
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
    this.userName,
    this.userPid,
    this.phone,
    this.isVip,
    this.vipEndTime,
    this.leaderName,
    this.userState,
    this.userLevel,
    this.headImg,
    this.nextLevelCount,
    this.companyName,
    this.levelCount,
    this.companyId,
    this.region,
    this.section,
    this.creatTime,
    this.inviteCount,
    this.sales,
    this.cs,
  });

  String userName;
  String userPid;
  String phone;
  bool isVip;
  DateTime vipEndTime;
  String leaderName;
  int userState;
  String userLevel;
  String headImg;
  int nextLevelCount;
  String companyName;
  int levelCount;
  String companyId;
  String region;
  String section;
  DateTime creatTime;
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
  "UserName": userName == null ? null : userName,
  "UserPID": userPid == null ? null : userPid,
  "Phone": phone == null ? null : phone,
  "IsVIP": isVip == null ? null : isVip,
  "VipEndTime": vipEndTime == null ? null : vipEndTime.toIso8601String(),
  "leaderName": leaderName == null ? null : leaderName,
  "UserState": userState == null ? null : userState,
  "UserLevel": userLevel == null ? null : userLevel,
  "HeadImg": headImg == null ? null : headImg,
  "NextLevelCount": nextLevelCount == null ? null : nextLevelCount,
  "CompanyName": companyName == null ? null : companyName,
    "LevelCount": levelCount == null ? null : levelCount,
    "CompanyID": companyId == null ? null : companyId,
    "Region": region == null ? null : region,
    "Section": section == null ? null : section,
    "CreatTime": creatTime == null ? null : creatTime.toIso8601String(),
    "inviteCount": inviteCount == null ? null : inviteCount,
    "sales": sales == null ? null : sales,
    "cs": cs == null ? null : cs,
  };
}