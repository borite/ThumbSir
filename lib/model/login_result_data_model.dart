// To parse this JSON data, do
//
//     final loginResultData = loginResultDataFromJson(jsonString);

import 'dart:convert';

LoginResultData loginResultDataFromJson(String str) => LoginResultData.fromJson(json.decode(str));

String loginResultDataToJson(LoginResultData data) => json.encode(data.toJson());

class LoginResultData {
  LoginResultData({
    required this.token,
    required this.exTokenTime,
    required this.userPid,
    required this.userName,
    required this.phone,
    this.headImg,
    this.sex,
    required this.userLevel,
    required this.leaderId,
    required this.companyId,
    required this.companyName,
    this.companyVipEndTime,
    this.companyLogo,
    required this.companyVip,
    required this.province,
    required this.city,
    this.remark,
    required this.section,
    required this.inviteCode,
    required this.userState,
    required this.userIsVip,
    this.userVipEndTime,
  });

  dynamic token;
  DateTime? exTokenTime;
  String userPid;
  String userName;
  String phone;
  dynamic headImg;
  dynamic sex;
  dynamic userLevel;
  dynamic leaderId;
  dynamic companyId;
  dynamic companyName;
  dynamic companyVipEndTime;
  dynamic companyLogo;
  dynamic companyVip;
  dynamic province;
  dynamic city;
  dynamic remark;
  dynamic section;
  dynamic inviteCode;
  dynamic userState;
  dynamic userIsVip;
  dynamic userVipEndTime;

  factory LoginResultData.fromJson(Map<String, dynamic> json) => LoginResultData(
    token: json["Token"],
    exTokenTime: json["EXTokenTime"] == null ? null : DateTime.parse(json["EXTokenTime"]),
    userPid: json["UserPID"],
    userName: json["UserName"],
    phone: json["Phone"],
    headImg: json["HeadImg"],
    sex: json["Sex"],
    userLevel: json["UserLevel"],
    leaderId: json["LeaderID"],
    companyId: json["CompanyID"],
    companyName: json["CompanyName"],
    companyVipEndTime: json["CompanyVipEndTime"],
    companyLogo: json["CompanyLogo"],
    companyVip: json["CompanyVIP"],
    province: json["Province"],
    city: json["City"],
    remark: json["Remark"],
    section: json["Section"],
    inviteCode: json["InviteCode"],
    userState: json["UserState"],
    userIsVip: json["UserIsVip"],
    userVipEndTime: json["UserVipEndTime"],
  );

  Map<String, dynamic> toJson() => {
    "Token": token,
    "EXTokenTime": exTokenTime?.toIso8601String(),
    "UserPID": userPid,
    "UserName": userName,
    "Phone": phone,
    "HeadImg": headImg,
    "Sex": sex,
    "UserLevel": userLevel,
    "LeaderID": leaderId,
    "CompanyID": companyId,
    "CompanyName": companyName,
    "CompanyVipEndTime": companyVipEndTime,
    "CompanyLogo": companyLogo,
    "CompanyVIP": companyVip,
    "Province": province,
    "City": city,
    "Remark": remark,
    "Section": section,
    "InviteCode": inviteCode,
    "UserState": userState,
    "UserIsVip": userIsVip,
    "UserVipEndTime": userVipEndTime,
  };
}