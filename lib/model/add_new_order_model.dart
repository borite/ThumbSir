// To parse this JSON data, do
//
//     final addNewOrder = addNewOrderFromJson(jsonString);

import 'dart:convert';

AddNewOrder addNewOrderFromJson(String str) => AddNewOrder.fromJson(json.decode(str));

String addNewOrderToJson(AddNewOrder data) => json.encode(data.toJson());

class AddNewOrder {
  AddNewOrder({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  String data;

  factory AddNewOrder.fromJson(Map<String, dynamic> json) => AddNewOrder(
    code: json["Code"],
    message: json["Message"],
    data: json["Data"],
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": data,
  };
}