// To parse this JSON data, do
//
//     final searchClientCustomer = searchClientCustomerFromJson(jsonString);

import 'dart:convert';

SearchClientCustomer searchClientCustomerFromJson(String str) => SearchClientCustomer.fromJson(json.decode(str));

String searchClientCustomerToJson(SearchClientCustomer data) => json.encode(data.toJson());

class SearchClientCustomer {
  SearchClientCustomer({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum> data;

  factory SearchClientCustomer.fromJson(Map<String, dynamic> json) => SearchClientCustomer(
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
    this.needs,
    this.busAct,
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
  String occupation;
  String income;
  String hobby;
  String remark;
  String address;
  List<dynamic> familyMember;
  List<Need> needs;
  BusAct busAct;
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
    occupation: json["occupation"] == null ? null : json["occupation"],
    income: json["Income"] == null ? null : json["Income"],
    hobby: json["Hobby"] == null ? null : json["Hobby"],
    remark: json["Remark"] == null ? null : json["Remark"],
    address: json["Address"] == null ? null : json["Address"],
    familyMember: json["FamilyMember"] == null ? null : List<dynamic>.from(json["FamilyMember"].map((x) => x)),
    needs: json["Needs"] == null ? null : List<Need>.from(json["Needs"].map((x) => Need.fromJson(x))),
    busAct: json["BusAct"] == null ? null : BusAct.fromJson(json["BusAct"]),
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
  "occupation": occupation == null ? null : occupation,
  "Income": income == null ? null : income,
  "Hobby": hobby == null ? null : hobby,
  "Remark": remark == null ? null : remark,
  "Address": address == null ? null : address,
  "FamilyMember": familyMember == null ? null : List<dynamic>.from(familyMember.map((x) => x)),
  "Needs": needs == null ? null : List<dynamic>.from(needs.map((x) => x.toJson())),
    "BusAct": busAct == null ? null : busAct.toJson(),
    "age": age == null ? null : age,
  };
}

class BusAct {
  BusAct({
    this.act,
  });

  List<Act> act;

  factory BusAct.fromJson(Map<String, dynamic> json) => BusAct(
    act: json["act"] == null ? null : List<Act>.from(json["act"].map((x) => Act.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "act": act == null ? null : List<dynamic>.from(act.map((x) => x.toJson())),
  };
}

class Act {
  Act({
    this.actionName,
    this.actionPlace,
    this.actionTime,
    this.actionDesc,
  });

  String actionName;
  String actionPlace;
  DateTime actionTime;
  String actionDesc;

  factory Act.fromJson(Map<String, dynamic> json) => Act(
    actionName: json["ActionName"] == null ? null : json["ActionName"],
    actionPlace: json["ActionPlace"] == null ? null : json["ActionPlace"],
    actionTime: json["ActionTime"] == null ? null : DateTime.parse(json["ActionTime"]),
    actionDesc: json["ActionDesc"] == null ? null : json["ActionDesc"],
  );

  Map<String, dynamic> toJson() => {
    "ActionName": actionName == null ? null : actionName,
    "ActionPlace": actionPlace == null ? null : actionPlace,
    "ActionTime": actionTime == null ? null : actionTime.toIso8601String(),
    "ActionDesc": actionDesc == null ? null : actionDesc,
  };
}

class Need {
  Need({
    this.mainNeed,
    this.coreNeedOne,
    this.coreNeedTwo,
    this.coreNeedThree,
  });

  String mainNeed;
  dynamic coreNeedOne;
  dynamic coreNeedTwo;
  dynamic coreNeedThree;

  factory Need.fromJson(Map<String, dynamic> json) => Need(
    mainNeed: json["MainNeed"] == null ? null : json["MainNeed"],
    coreNeedOne: json["CoreNeedOne"],
    coreNeedTwo: json["CoreNeedTwo"],
    coreNeedThree: json["CoreNeedThree"],
  );

  Map<String, dynamic> toJson() => {
    "MainNeed": mainNeed == null ? null : mainNeed,
    "CoreNeedOne": coreNeedOne,
    "CoreNeedTwo": coreNeedTwo,
    "CoreNeedThree": coreNeedThree,
  };
}