// To parse this JSON data, do
//
//     final loginResultData = loginResultDataFromJson(jsonString);

import 'dart:convert';

LoginResultData loginResultDataFromJson(String str) => LoginResultData.fromJson(json.decode(str));

String loginResultDataToJson(LoginResultData data) => json.encode(data.toJson());

class LoginResultData {
  LoginResultData({
    this.token,
    this.exTokenTime,
    this.userPid,
    this.userName,
    this.phone,
    this.headImg,
    this.sex,
    this.userLevel,
    this.leaderId,
    this.companyId,
    this.companyName,
    this.companyVipEndTime,
    this.companyLogo,
    this.companyVip,
    this.province,
    this.city,
    this.remark,
    this.section,
    this.inviteCode,
    this.userState,
    this.userIsVip,
    this.userVipEndTime,
  });

  String token;
  DateTime exTokenTime;
  String userPid;
  String userName;
  String phone;
  dynamic headImg;
  dynamic sex;
  String userLevel;
  String leaderId;
  String companyId;
  String companyName;
  dynamic companyVipEndTime;
  dynamic companyLogo;
  bool companyVip;
  String province;
  String city;
  dynamic remark;
  String section;
  String inviteCode;
  int userState;
  bool userIsVip;
  dynamic userVipEndTime;

  factory LoginResultData.fromJson(Map<String, dynamic> json) => LoginResultData(
  token: json["Token"] == null ? null : json["Token"],
  exTokenTime: json["EXTokenTime"] == null ? null : DateTime.parse(json["EXTokenTime"]),
  userPid: json["UserPID"] == null ? null : json["UserPID"],
  userName: json["UserName"] == null ? null : json["UserName"],
  phone: json["Phone"] == null ? null : json["Phone"],
  headImg: json["HeadImg"],
  sex: json["Sex"],
  userLevel: json["UserLevel"] == null ? null : json["UserLevel"],
  leaderId: json["LeaderID"] == null ? null : json["LeaderID"],
    companyId: json["CompanyID"] == null ? null : json["CompanyID"],
    companyName: json["CompanyName"] == null ? null : json["CompanyName"],
    companyVipEndTime: json["CompanyVipEndTime"],
    companyLogo: json["CompanyLogo"],
    companyVip: json["CompanyVIP"] == null ? null : json["CompanyVIP"],
    province: json["Province"] == null ? null : json["Province"],
    city: json["City"] == null ? null : json["City"],
    remark: json["Remark"],
    section: json["Section"] == null ? null : json["Section"],
    inviteCode: json["InviteCode"] == null ? null : json["InviteCode"],
    userState: json["UserState"] == null ? null : json["UserState"],
    userIsVip: json["UserIsVip"] == null ? null : json["UserIsVip"],
    userVipEndTime: json["UserVipEndTime"],
  );

  Map<String, dynamic> toJson() => {
    "Token": token == null ? null : token,
    "EXTokenTime": exTokenTime == null ? null : exTokenTime.toIso8601String(),
    "UserPID": userPid == null ? null : userPid,
    "UserName": userName == null ? null : userName,
    "Phone": phone == null ? null : phone,
    "HeadImg": headImg,
    "Sex": sex,
    "UserLevel": userLevel == null ? null : userLevel,
    "LeaderID": leaderId == null ? null : leaderId,
    "CompanyID": companyId == null ? null : companyId,
    "CompanyName": companyName == null ? null : companyName,
    "CompanyVipEndTime": companyVipEndTime,
    "CompanyLogo": companyLogo,
    "CompanyVIP": companyVip == null ? null : companyVip,
    "Province": province == null ? null : province,
    "City": city == null ? null : city,
    "Remark": remark,
    "Section": section == null ? null : section,
    "InviteCode": inviteCode == null ? null : inviteCode,
    "UserState": userState == null ? null : userState,
    "UserIsVip": userIsVip == null ? null : userIsVip,
    "UserVipEndTime": userVipEndTime,
  };
}