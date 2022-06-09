// To parse this JSON data, do
//
//     final getNextLevelCustomer = getNextLevelCustomerFromJson(jsonString);

import 'dart:convert';

GetNextLevelCustomer getNextLevelCustomerFromJson(String str) => GetNextLevelCustomer.fromJson(json.decode(str));

String getNextLevelCustomerToJson(GetNextLevelCustomer data) => json.encode(data.toJson());

class GetNextLevelCustomer {
  GetNextLevelCustomer({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory GetNextLevelCustomer.fromJson(Map<String, dynamic> json) => GetNextLevelCustomer(
    code: json["Code"] == null ? null : json["Code"],
    message: json["Message"] == null ? null : json["Message"],
    data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    required this.currentLevel,
    required this.countNums,
    this.list,
  });

  String currentLevel;
  int countNums;
  List<ListElement>? list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentLevel: json["currentLevel"] == null ? null : json["currentLevel"],
    countNums: json["countNums"] == null ? null : json["countNums"],
    list: json["list"] == null ? null : List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "currentLevel": currentLevel == null ? null : currentLevel,
    "countNums": countNums == null ? null : countNums,
    "list": list == null ? null : List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    required this.teamName,
    required this.customerNum,
    this.nextLeader,
  });

  String teamName;
  int customerNum;
  NextLeader? nextLeader;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    teamName: json["teamName"] == null ? null : json["teamName"],
    customerNum: json["customerNum"] == null ? null : json["customerNum"],
    nextLeader: json["nextLeader"] == null ? null : NextLeader.fromJson(json["nextLeader"]),
  );

  Map<String, dynamic> toJson() => {
    "teamName": teamName,
    "customerNum": customerNum,
    "nextLeader": nextLeader == null ? null : nextLeader!.toJson(),
  };
}

class NextLeader {
  NextLeader({
    required this.userPid,
    required this.userName,
  });

  String userPid;
  String userName;

  factory NextLeader.fromJson(Map<String, dynamic> json) => NextLeader(
    userPid: json["UserPID"] == null ? null : json["UserPID"],
    userName: json["UserName"] == null ? null : json["UserName"],
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid,
    "UserName": userName,
  };
}
