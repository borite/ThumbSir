// To parse this JSON data, do
//
//     final getLastLevelCustomerNum = getLastLevelCustomerNumFromJson(jsonString);

import 'dart:convert';

GetLastLevelCustomerNum getLastLevelCustomerNumFromJson(String str) => GetLastLevelCustomerNum.fromJson(json.decode(str));

String getLastLevelCustomerNumToJson(GetLastLevelCustomerNum data) => json.encode(data.toJson());

class GetLastLevelCustomerNum {
  GetLastLevelCustomerNum({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  Data data;

  factory GetLastLevelCustomerNum.fromJson(Map<String, dynamic> json) => GetLastLevelCustomerNum(
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
  Data({
    this.zong,
    this.list,
  });

  int zong;
  List<ListElement> list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    zong: json["zong"] == null ? null : json["zong"],
    list: json["list"] == null ? null : List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "zong": zong == null ? null : zong,
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    this.userPid,
    this.userName,
    this.headImg,
    this.userLevel,
    this.customerCount,
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
    "UserPID": userPid == null ? null : userPid,
    "UserName": userName == null ? null : userName,
    "HeadImg": headImg == null ? null : headImg,
    "UserLevel": userLevel == null ? null : userLevel,
    "customerCount": customerCount == null ? null : customerCount,
  };
}