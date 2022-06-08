// To parse this JSON data, do
//
//     final addHouseStep1 = addHouseStep1FromJson(jsonString);

import 'dart:convert';

AddHouseStep1 addHouseStep1FromJson(String str) => AddHouseStep1.fromJson(json.decode(str));

String addHouseStep1ToJson(AddHouseStep1 data) => json.encode(data.toJson());

class AddHouseStep1 {
  AddHouseStep1({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  Data data;

  factory AddHouseStep1.fromJson(Map<String, dynamic> json) => AddHouseStep1(
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
    this.newUserId,
    this.houseId,
  });

  int newUserId;
  int houseId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    newUserId: json["newUserID"] == null ? null : json["newUserID"],
    houseId: json["HouseID"] == null ? null : json["HouseID"],
  );

  Map<String, dynamic> toJson() => {
    "newUserID": newUserId == null ? null : newUserId,
    "HouseID": houseId == null ? null : houseId,
  };
}