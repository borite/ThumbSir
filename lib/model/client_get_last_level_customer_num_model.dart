// To parse this JSON data, do
//
//     final clientGetLastLevelCustomerNum = clientGetLastLevelCustomerNumFromJson(jsonString);

import 'dart:convert';

ClientGetLastLevelCustomerNum clientGetLastLevelCustomerNumFromJson(String str) => ClientGetLastLevelCustomerNum.fromJson(json.decode(str));

String clientGetLastLevelCustomerNumToJson(ClientGetLastLevelCustomerNum data) => json.encode(data.toJson());

class ClientGetLastLevelCustomerNum {
  ClientGetLastLevelCustomerNum({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  Data data;

  factory ClientGetLastLevelCustomerNum.fromJson(Map<String, dynamic> json) => ClientGetLastLevelCustomerNum(
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
    this.levelLeaderData,
    this.list,
  });

  LevelLeaderData levelLeaderData;
  List<ListElement> list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    levelLeaderData: json["LevelLeaderData"] == null ? null : LevelLeaderData.fromJson(json["LevelLeaderData"]),
    list: json["list"] == null ? null : List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "LevelLeaderData": levelLeaderData == null ? null : levelLeaderData.toJson(),
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class LevelLeaderData {
  LevelLeaderData({
    this.yeZhuCount,
    this.keHuCount,
    this.duoXuQiuCount,
  });

  int yeZhuCount;
  int keHuCount;
  int duoXuQiuCount;

  factory LevelLeaderData.fromJson(Map<String, dynamic> json) => LevelLeaderData(
    yeZhuCount: json["YeZhuCount"] == null ? null : json["YeZhuCount"],
    keHuCount: json["KeHuCount"] == null ? null : json["KeHuCount"],
    duoXuQiuCount: json["DuoXuQiuCount"] == null ? null : json["DuoXuQiuCount"],
  );

  Map<String, dynamic> toJson() => {
    "YeZhuCount": yeZhuCount == null ? null : yeZhuCount,
    "KeHuCount": keHuCount == null ? null : keHuCount,
    "DuoXuQiuCount": duoXuQiuCount == null ? null : duoXuQiuCount,
  };
}

class ListElement {
  ListElement({
    this.userPid,
    this.userName,
    this.headImg,
    this.userLevel,
    this.kehuNums,
    this.yezhuNums,
    this.duoXuQiuNums,
  });

  String userPid;
  String userName;
  String headImg;
  String userLevel;
  int kehuNums;
  int yezhuNums;
  int duoXuQiuNums;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    userPid: json["UserPID"] == null ? null : json["UserPID"],
    userName: json["UserName"] == null ? null : json["UserName"],
    headImg: json["HeadImg"] == null ? null : json["HeadImg"],
    userLevel: json["UserLevel"] == null ? null : json["UserLevel"],
    kehuNums: json["kehuNums"] == null ? null : json["kehuNums"],
    yezhuNums: json["yezhuNums"] == null ? null : json["yezhuNums"],
    duoXuQiuNums: json["duoXuQiuNums"] == null ? null : json["duoXuQiuNums"],
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid == null ? null : userPid,
    "UserName": userName == null ? null : userName,
    "HeadImg": headImg == null ? null : headImg,
    "UserLevel": userLevel == null ? null : userLevel,
    "kehuNums": kehuNums == null ? null : kehuNums,
    "yezhuNums": yezhuNums == null ? null : yezhuNums,
    "duoXuQiuNums": duoXuQiuNums == null ? null : duoXuQiuNums,
  };
}