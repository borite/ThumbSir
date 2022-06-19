// To parse this JSON data, do
//
//     final getUserDetailById = getUserDetailByIdFromJson(jsonString);

import 'dart:convert';

GetUserDetailById getUserDetailByIdFromJson(String str) => GetUserDetailById.fromJson(json.decode(str));

String getUserDetailByIdToJson(GetUserDetailById data) => json.encode(data.toJson());

class GetUserDetailById {
  GetUserDetailById({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum>? data;

  factory GetUserDetailById.fromJson(Map<String, dynamic> json) => GetUserDetailById(
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
    required this.occupation,
    required this.income,
    this.hobby,
    this.remark,
    this.address,
    this.familyMember,
    this.needs,
    this.busAct,
    this.age,
  });

  int mid;
  String userId;
  int userType;
  String userName;
  dynamic sex;
  dynamic phone;
  DateTime? birthday;
  dynamic starslevel;
  dynamic occupation;
  dynamic income;
  dynamic hobby;
  dynamic remark;
  dynamic address;
  List<FamilyMember>? familyMember;
  List<Need>? needs;
  BusAct? busAct;
  dynamic age;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
  mid: json["MID"] == null ? null : json["MID"],
  userId: json["UserID"] == null ? null : json["UserID"],
    userType: json["UserType"] == null ? null : json["UserType"],
    userName: json["UserName"] == null ? null : json["UserName"],
    sex: json["Sex"] == null ? null : json["Sex"],
    phone: json["Phone"] == null ? null : json["Phone"],
    birthday: json["Birthday"] == null ? null : DateTime.parse(json["Birthday"]),
    starslevel: json["Starslevel"] == null ? null : json["Starslevel"],
    occupation: json["occupation"] == null ? null : json["occupation"],
    income: json["Income"] == null ? null : json["Income"],
    hobby: json["Hobby"] == null ? null : json["Hobby"],
    remark: json["Remark"] == null ? null : json["Remark"],
    address: json["Address"] == null ? null : json["Address"],
    familyMember: json["FamilyMember"] == null ? null : List<FamilyMember>.from(json["FamilyMember"].map((x) => FamilyMember.fromJson(x))),
    needs: json["Needs"] == null ? null : List<Need>.from(json["Needs"].map((x) => Need.fromJson(x))),
    busAct: json["BusAct"] == null ? null : BusAct.fromJson(json["BusAct"]),
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
    "Needs": needs == null ? null : List<dynamic>.from(needs!.map((x) => x.toJson())),
    "BusAct": busAct == null ? null : busAct!.toJson(),
    "age": age == null ? null : age,
  };
}

class BusAct {
  BusAct({
    this.act,
  });

  List<Act>? act;

  factory BusAct.fromJson(Map<String, dynamic> json) => BusAct(
    act: json["act"] == null ? null : List<Act>.from(json["act"].map((x) => Act.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "act": act == null ? null : List<dynamic>.from(act!.map((x) => x.toJson())),
  };
}

class Act {
  Act({
    required this.actionName,
    required this.actionPlace,
    this.actionTime,
    this.actionDesc,
  });

  String actionName;
  String actionPlace;
  DateTime? actionTime;
  String? actionDesc;

  factory Act.fromJson(Map<String, dynamic> json) => Act(
    actionName: json["ActionName"] == null ? null : json["ActionName"],
    actionPlace: json["ActionPlace"] == null ? null : json["ActionPlace"],
    actionTime: json["ActionTime"] == null ? null : DateTime.parse(json["ActionTime"]),
    actionDesc: json["ActionDesc"] == null ? null : json["ActionDesc"],
  );

  Map<String, dynamic> toJson() => {
    "ActionName": actionName,
    "ActionPlace": actionPlace,
    "ActionTime": actionTime == null ? null : actionTime!.toIso8601String(),
    "ActionDesc": actionDesc == null ? null : actionDesc,
  };
}

class FamilyMember {
  FamilyMember({
    required this.userInfoMain,
    required this.id,
    required this.mid,
    this.memberRole,
    this.memberHobby,
  });

  String userInfoMain;
  int id;
  int mid;
  String? memberRole;
  String? memberHobby;

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
  userInfoMain: json["UserInfoMain"] == null ? null : json["UserInfoMain"],
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

class Need {
  Need({
    required this.id,
    required this.mainNeed,
    this.coreNeedOne,
    this.coreNeedTwo,
    this.coreNeedThree,
  });

  int id;
  String mainNeed;
  dynamic coreNeedOne;
  dynamic coreNeedTwo;
  dynamic coreNeedThree;

  factory Need.fromJson(Map<String, dynamic> json) => Need(
    id: json["ID"] == null ? null : json["ID"],
    mainNeed: json["MainNeed"] == null ? null : json["MainNeed"],
    coreNeedOne: json["CoreNeedOne"] == null ? null : json["CoreNeedOne"],
    coreNeedTwo: json["CoreNeedTwo"] == null ? null : json["CoreNeedTwo"],
    coreNeedThree: json["CoreNeedThree"] == null ? null : json["CoreNeedThree"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "MainNeed": mainNeed,
    "CoreNeedOne": coreNeedOne,
    "CoreNeedTwo": coreNeedTwo,
    "CoreNeedThree": coreNeedThree,
  };
}
