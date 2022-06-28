// To parse this JSON data, do
//
//     final getHouseInMission = getHouseInMissionFromJson(jsonString);

import 'dart:convert';

GetHouseInMission getHouseInMissionFromJson(String str) => GetHouseInMission.fromJson(json.decode(str));

String getHouseInMissionToJson(GetHouseInMission data) => json.encode(data.toJson());

class GetHouseInMission {
  GetHouseInMission({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum>? data;

  factory GetHouseInMission.fromJson(Map<String, dynamic> json) => GetHouseInMission(
    code: json["Code"],
    message: json["Message"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.haid,
    required this.houseId,
    required this.houseNum,
    required this.houseCommunity,
    required this.houseAddress,
  });

  int haid;
  int houseId;
  String houseNum;
  String houseCommunity;
  String houseAddress;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    haid: json["HAID"],
    houseId: json["HouseID"],
    houseNum: json["HouseNum"],
    houseCommunity: json["HouseCommunity"],
    houseAddress: json["HouseAddress"],
  );

  Map<String, dynamic> toJson() => {
    "HAID": haid,
    "HouseID": houseId,
    "HouseNum": houseNum,
    "HouseCommunity": houseCommunity,
    "HouseAddress": houseAddress,
  };
}