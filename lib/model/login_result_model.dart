// To parse this JSON data, do
//
//     final loginResult = loginResultFromJson(jsonString);

import 'dart:convert';

LoginResult loginResultFromJson(String str) => LoginResult.fromJson(json.decode(str));

String loginResultToJson(LoginResult data) => json.encode(data.toJson());

class LoginResult {
  int code;
  String message;
  Data data;

  LoginResult({
    this.code,
    this.message,
    this.data,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
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
  String token;
  DateTime exTokenTime;
  String userPid;
  String userName;
  String phone;
  dynamic headImg;
  dynamic sex;
  String userLevel;
  dynamic leaderId;
  String companyName;
  String companyId;
  dynamic companyLogo;
  bool isVip;
  dynamic vipEndTime;
  String province;
  String city;
  dynamic remark;
  String section;
  int userState;

  Data({
    this.token,
    this.exTokenTime,
    this.userPid,
    this.userName,
    this.phone,
    this.headImg,
    this.sex,
    this.userLevel,
    this.leaderId,
    this.companyName,
    this.companyId,
    this.companyLogo,
    this.isVip,
    this.vipEndTime,
    this.province,
    this.city,
    this.remark,
    this.section,
    this.userState,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["Token"] == null ? null : json["Token"],
    exTokenTime: json["EXTokenTime"] == null ? null : DateTime.parse(json["EXTokenTime"]),
    userPid: json["UserPID"] == null ? null : json["UserPID"],
    userName: json["UserName"] == null ? null : json["UserName"],
    phone: json["Phone"] == null ? null : json["Phone"],
    headImg: json["HeadImg"],
    sex: json["Sex"],
    userLevel: json["UserLevel"] == null ? null : json["UserLevel"],
    leaderId: json["LeaderID"],
    companyName: json["CompanyName"] == null ? null : json["CompanyName"],
    companyId: json["CompanyID"] == null ? null : json["CompanyID"],
    companyLogo: json["CompanyLogo"],
    isVip: json["IsVIP"] == null ? null : json["IsVIP"],
    vipEndTime: json["VipEndTime"],
    province: json["Province"] == null ? null : json["Province"],
    city: json["City"] == null ? null : json["City"],
    remark: json["Remark"],
    section: json["Section"] == null ? null : json["Section"],
    userState: json["UserState"] == null ? null : json["UserState"],
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
    "LeaderID": leaderId,
    "CompanyName": companyName == null ? null : companyName,
    "CompanyID": companyId == null ? null : companyId,
    "CompanyLogo": companyLogo,
    "IsVIP": isVip == null ? null : isVip,
    "VipEndTime": vipEndTime,
    "Province": province == null ? null : province,
    "City": city == null ? null : city,
    "Remark": remark,
    "Section": section == null ? null : section,
    "UserState": userState == null ? null : userState,
  };
}
