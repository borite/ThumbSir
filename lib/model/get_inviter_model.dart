// To parse this JSON data, do
//
//     final getInviter = getInviterFromJson(jsonString);

import 'dart:convert';

GetInviter getInviterFromJson(String str) => GetInviter.fromJson(json.decode(str));

String getInviterToJson(GetInviter data) => json.encode(data.toJson());

class GetInviter {
  GetInviter({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  Data data;

  factory GetInviter.fromJson(Map<String, dynamic> json) => GetInviter(
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
    this.userName,
    this.beInvited,
  });

  String userName;
  String beInvited;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userName: json["UserName"] == null ? null : json["UserName"],
    beInvited: json["BeInvited"] == null ? null : json["BeInvited"],
  );

  Map<String, dynamic> toJson() => {
    "UserName": userName == null ? null : userName,
    "BeInvited": beInvited == null ? null : beInvited,
  };
}