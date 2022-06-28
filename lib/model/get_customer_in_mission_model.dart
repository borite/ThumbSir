// To parse this JSON data, do
//
//     final getCustomerInMission = getCustomerInMissionFromJson(jsonString);

import 'dart:convert';

GetCustomerInMission getCustomerInMissionFromJson(String str) => GetCustomerInMission.fromJson(json.decode(str));

String getCustomerInMissionToJson(GetCustomerInMission data) => json.encode(data.toJson());

class GetCustomerInMission {
  GetCustomerInMission({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum>? data;

  factory GetCustomerInMission.fromJson(Map<String, dynamic> json) => GetCustomerInMission(
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
    required this.caid,
    this.customerId,
    this.userName,
    this.phone,
    this.description,
  });

  int caid;
  dynamic customerId;
  dynamic userName;
  dynamic phone;
  dynamic description;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    caid: json["CAID"],
    customerId: json["CustomerID"],
    userName: json["UserName"],
    phone: json["Phone"],
    description: json["Description"],
  );

  Map<String, dynamic> toJson() => {
    "CAID": caid,
    "CustomerID": customerId,
    "UserName": userName,
    "Phone": phone,
    "Description": description,
  };
}
