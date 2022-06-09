// To parse this JSON data, do
//
//     final getInvitedUser = getInvitedUserFromJson(jsonString);

import 'dart:convert';

GetInvitedUser getInvitedUserFromJson(String str) => GetInvitedUser.fromJson(json.decode(str));

String getInvitedUserToJson(GetInvitedUser data) => json.encode(data.toJson());

class GetInvitedUser {
  GetInvitedUser({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory GetInvitedUser.fromJson(Map<String, dynamic> json) => GetInvitedUser(
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
    required this.tcount,
    this.list,
  });

  int tcount;
  List<ListElement>? list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    tcount: json["tcount"] == null ? null : json["tcount"],
    list: json["list"] == null ? null : List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tcount": tcount == null ? null : tcount,
    "list": list == null ? null : List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    required this.userName,
    this.headImg,
    required this.phone,
    this.creatTime,
  });

  String userName;
  dynamic headImg;
  String phone;
  DateTime? creatTime;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    userName: json["UserName"] == null ? null : json["UserName"],
    headImg: json["HeadImg"],
    phone: json["Phone"] == null ? null : json["Phone"],
    creatTime: json["CreatTime"] == null ? null : DateTime.parse(json["CreatTime"]),
  );

  Map<String, dynamic> toJson() => {
    "UserName": userName == null ? null : userName,
    "HeadImg": headImg,
    "Phone": phone == null ? null : phone,
    "CreatTime": creatTime == null ? null : creatTime!.toIso8601String(),
  };
}