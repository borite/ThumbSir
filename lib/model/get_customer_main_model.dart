// To parse this JSON data, do
//
//     final getCustomerMain = getCustomerMainFromJson(jsonString);

import 'dart:convert';

GetCustomerMain getCustomerMainFromJson(String str) => GetCustomerMain.fromJson(json.decode(str));

String getCustomerMainToJson(GetCustomerMain data) => json.encode(data.toJson());

class GetCustomerMain {
  GetCustomerMain({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum>? data;

  factory GetCustomerMain.fromJson(Map<String, dynamic> json) => GetCustomerMain(
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
    required this.mid,
    required this.userId,
    required this.userType,
    required this.userName,
    required this.sex,
    required this.phone,
    this.birthday,
    required this.starslevel,
    this.occupation,
    required this.income,
    this.hobby,
    this.remark,
    this.address,
    this.familyMember,
    this.dealList,
    required this.age,
  });

  int mid;
  String userId;
  int userType;
  String userName;
  int sex;
  String phone;
  DateTime? birthday;
  int starslevel;
  dynamic occupation;
  String income;
  dynamic hobby;
  dynamic remark;
  dynamic address;
  List<FamilyMember>? familyMember;
  List<DealList>? dealList;
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
    "MID": mid,
    "UserID": userId,
    "UserType": userType,
    "UserName": userName,
    "Sex": sex,
    "Phone": phone,
    "Birthday": birthday == null ? null : birthday!.toIso8601String(),
    "Starslevel": starslevel,
    "occupation": occupation,
    "Income": income,
    "Hobby": hobby == null ? null : hobby,
    "Remark": remark == null ? null : remark,
    "Address": address == null ? null : address,
    "FamilyMember": familyMember == null ? null : List<dynamic>.from(familyMember!.map((x) => x.toJson())),
    "DealList": dealList == null ? null : List<dynamic>.from(dealList!.map((x) => x.toJson())),
    "age": age,
  };
}

class DealList {
  DealList({
  this.userInfoMain,
  required this.id,
  required this.mid,
  this.finishTime,
  required this.dealReason,
  this.address,
    this.dealArea,
    this.dealPrice,
    this.dealRemark,
  });

  dynamic userInfoMain;
  int id;
  int mid;
  DateTime? finishTime;
  String dealReason;
  dynamic address;
  dynamic dealArea;
  dynamic dealPrice;
  dynamic dealRemark;

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
    "ID": id,
    "MID": mid,
    "FinishTime": finishTime == null ? null : finishTime!.toIso8601String(),
    "DealReason": dealReason,
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
  dynamic id;
  dynamic mid;
  dynamic memberRole;
  dynamic memberHobby;

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
  userInfoMain: json["UserInfoMain"],
  id: json["ID"] == null ? null : json["ID"],
  mid: json["MID"] == null ? null : json["MID"],
    memberRole: json["MemberRole"] == null ? null : json["MemberRole"],
    memberHobby: json["MemberHobby"] == null ? null : json["MemberHobby"],
  );

  Map<String, dynamic> toJson() => {
    "UserInfoMain": userInfoMain,
    "ID": id,
    "MID": mid,
    "MemberRole": memberRole == null ? null : memberRole,
    "MemberHobby": memberHobby == null ? null : memberHobby,
  };
}
