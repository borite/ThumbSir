// To parse this JSON data, do
//
//     final getLastLevelCustomerNum = getLastLevelCustomerNumFromJson(jsonString);

import 'dart:convert';

GetLastLevelCustomerNum getLastLevelCustomerNumFromJson(String str) => GetLastLevelCustomerNum.fromJson(json.decode(str));

String getLastLevelCustomerNumToJson(GetLastLevelCustomerNum data) => json.encode(data.toJson());

class GetLastLevelCustomerNum {
  GetLastLevelCustomerNum({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory GetLastLevelCustomerNum.fromJson(Map<String, dynamic> json) => GetLastLevelCustomerNum(
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
    this.zong,
    this.list,
  });

  int? zong;
  List<ListElement>? list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    zong: json["zong"] == null ? null : json["zong"],
    list: json["list"] == null ? null : List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "zong": zong == null ? null : zong,
    "list": list == null ? null : List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    required this.userPid,
    required this.userName,
    required this.headImg,
    required this.userLevel,
    required this.customerCount,
  });

  String userPid;
  String userName;
  String headImg;
  String userLevel;
  int customerCount;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
  userPid: json["UserPID"] == null ? null : json["UserPID"],
    userName: json["UserName"] == null ? null : json["UserName"],
    headImg: json["HeadImg"] == null ? null : json["HeadImg"],
    userLevel: json["UserLevel"] == null ? null : json["UserLevel"],
    customerCount: json["customerCount"] == null ? null : json["customerCount"],
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid,
    "UserName": userName,
    "HeadImg": headImg,
    "UserLevel": userLevel,
    "customerCount": customerCount,
  };
}