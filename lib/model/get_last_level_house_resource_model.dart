// To parse this JSON data, do
//
//     final getLastLevelHouseResource = getLastLevelHouseResourceFromJson(jsonString);

import 'dart:convert';

GetLastLevelHouseResource getLastLevelHouseResourceFromJson(String str) => GetLastLevelHouseResource.fromJson(json.decode(str));

String getLastLevelHouseResourceToJson(GetLastLevelHouseResource data) => json.encode(data.toJson());

class GetLastLevelHouseResource {
  GetLastLevelHouseResource({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory GetLastLevelHouseResource.fromJson(Map<String, dynamic> json) => GetLastLevelHouseResource(
    code: json["Code"],
    message: json["Message"],
    data: Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": data!.toJson(),
  };
}

class Data {
  Data({
    required this.houseCount,
    this.list,
  });

  int houseCount;
  List<ListElement>? list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    houseCount: json["houseCount"],
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "houseCount": houseCount,
    "list": List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    required this.userPid,
    required this.userName,
    this.headImg,
    required this.userLevel,
    this.houseIDs,
    required this.houseCount,
  });

  String userPid;
  String userName;
  dynamic headImg;
  String userLevel;
  dynamic houseIDs;
  int houseCount;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    userPid: json["UserPID"],
    userName: json["UserName"],
    headImg: json["HeadImg"],
    userLevel: json["UserLevel"],
    houseIDs: List<int>.from(json["HouseIDs"].map((x) => x)),
    houseCount: json["HouseCount"],
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid,
    "UserName": userName,
    "HeadImg": headImg,
    "UserLevel": userLevel,
    "HouseIDs": List<dynamic>.from(houseIDs.map((x) => x)),
    "HouseCount": houseCount,
  };
}