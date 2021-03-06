// To parse this JSON data, do
//
//     final getCustomerInfo = getCustomerInfoFromJson(jsonString);

import 'dart:convert';

import 'dart:wasm';

GetCustomerInfo getCustomerInfoFromJson(String str) => GetCustomerInfo.fromJson(json.decode(str));

String getCustomerInfoToJson(GetCustomerInfo data) => json.encode(data.toJson());

class GetCustomerInfo {
  GetCustomerInfo({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum> data;

  factory GetCustomerInfo.fromJson(Map<String, dynamic> json) => GetCustomerInfo(
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
    this.mid,
    this.userId,
    this.userType,
    this.userName,
    this.sex,
    this.phone,
    this.birthday,
    this.starslevel,
    this.occupation,
    this.income,
    this.hobby,
    this.remark,
    this.address,
    this.familyMember,
    this.dealList,
    this.age,
  });

  int mid;
  String userId;
  int userType;
  String userName;
  int sex;
  String phone;
  DateTime birthday;
  int starslevel;
  dynamic occupation;
  String income;
  String hobby;
  String remark;
  String address;
  List<FamilyMember> familyMember;
  List<DealList> dealList;
  int age;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
  mid: json["MID"] == null ? null : json["MID"],
  userId: json["UserID"] == null ? null : json["UserID"],
  userType: json["UserType"] == null ? null : json["UserType"],
    userName: json["UserName"] == null ? null : json["UserName"],
    sex: json["Sex"] == null ? null : json["Sex"],
    phone: json["Phone"] == null ? null : json["Phone"],
    birthday: json["Birthday"] == null ? null : DateTime.parse(json["Birthday"]),
    starslevel: json["Starslevel"] == null ? null : json["Starslevel"],
    occupation: json["occupation"],
    income: json["Income"] == null ? null : json["Income"],
    hobby: json["Hobby"] == null ? null : json["Hobby"],
    remark: json["Remark"] == null ? null : json["Remark"],
    address: json["Address"] == null ? null : json["Address"],
    familyMember: json["FamilyMember"] == null ? null : List<FamilyMember>.from(json["FamilyMember"].map((x) => FamilyMember.fromJson(x))),
    dealList: json["DealList"] == null ? null : List<DealList>.from(json["DealList"].map((x) => DealList.fromJson(x))),
    age: json["age"] == null ? null : json["age"],
  );

  Map<String, dynamic> toJson() => {
    "MID": mid == null ? null : mid,
    "UserID": userId == null ? null : userId,
    "UserType": userType == null ? null : userType,
    "UserName": userName == null ? null : userName,
    "Sex": sex == null ? null : sex,
    "Phone": phone == null ? null : phone,
    "Birthday": birthday == null ? null : birthday.toIso8601String(),
    "Starslevel": starslevel == null ? null : starslevel,
    "occupation": occupation,
    "Income": income == null ? null : income,
    "Hobby": hobby == null ? null : hobby,
    "Remark": remark == null ? null : remark,
    "Address": address == null ? null : address,
    "FamilyMember": familyMember == null ? null : List<dynamic>.from(familyMember.map((x) => x.toJson())),
    "DealList": dealList == null ? null : List<dynamic>.from(dealList.map((x) => x.toJson())),
    "age": age == null ? null : age,
  };
}

class DealList {
  DealList({
  this.userInfoMain,
  this.id,
  this.mid,
    this.finishTime,
    this.dealReason,
    this.address,
    this.dealArea,
    this.dealPrice,
    this.dealRemark,
  });

  dynamic userInfoMain;
  int id;
  int mid;
  DateTime finishTime;
  String dealReason;
  String address;
  String dealArea;
  double dealPrice;
  String dealRemark;

  factory DealList.fromJson(Map<String, dynamic> json) => DealList(
    userInfoMain: json["UserInfoMain"],
    id: json["ID"] == null ? null : json["ID"],
    mid: json["MID"] == null ? null : json["MID"],
    finishTime: json["FinishTime"] == null ? null : DateTime.parse(json["FinishTime"]),
    dealReason: json["DealReason"] == null ? null : json["DealReason"],
    address: json["Address"] == null ? null : json["Address"],
    dealArea: json["DealArea"] == null ? null : json["DealArea"],
    dealPrice: json["DealPrice"] == null ? null : json["DealPrice"],
    dealRemark: json["DealRemark"] == null ? null : json["DealRemark"],
  );

  Map<String, dynamic> toJson() => {
    "UserInfoMain": userInfoMain,
    "ID": id == null ? null : id,
    "MID": mid == null ? null : mid,
    "FinishTime": finishTime == null ? null : finishTime.toIso8601String(),
    "DealReason": dealReason == null ? null : dealReason,
    "Address": address == null ? null : address,
    "DealArea": dealArea == null ? null : dealArea,
    "DealPrice": dealPrice == null ? null : dealPrice,
    "DealRemark": dealRemark == null ? null : dealRemark,
  };
}

class FamilyMember {
  FamilyMember({
    this.userInfoMain,
    this.id,
    this.mid,
    this.memberRole,
    this.memberHobby,
  });

  dynamic userInfoMain;
  int id;
  int mid;
  dynamic memberRole;
  dynamic memberHobby;

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
  userInfoMain: json["UserInfoMain"],
  id: json["ID"] == null ? null : json["ID"],
    mid: json["MID"] == null ? null : json["MID"],
    memberRole: json["MemberRole"],
    memberHobby: json["MemberHobby"],
  );

  Map<String, dynamic> toJson() => {
    "UserInfoMain": userInfoMain,
    "ID": id == null ? null : id,
    "MID": mid == null ? null : mid,
    "MemberRole": memberRole,
    "MemberHobby": memberHobby,
  };
}
