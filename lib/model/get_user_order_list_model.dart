// To parse this JSON data, do
//
//     final getUserOrderList = getUserOrderListFromJson(jsonString);

import 'dart:convert';

GetUserOrderList getUserOrderListFromJson(String str) => GetUserOrderList.fromJson(json.decode(str));

String getUserOrderListToJson(GetUserOrderList data) => json.encode(data.toJson());

class GetUserOrderList {
  GetUserOrderList({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum>? data;

  factory GetUserOrderList.fromJson(Map<String, dynamic> json) => GetUserOrderList(
    code: json["Code"],
    message: json["Message"],
    data: json["Data"] == null ? null : List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.orderId,
    required this.orderName,
    this.orderTime,
    required this.unitPrice,
    required this.orderCount,
    required this.orderTotalPrice,
    required this.orderState,
    required this.orderPayWay,
    required this.orderRemark,
    required this.orderUserId,
    this.payTime,
  });

  String orderId;
  String orderName;
  DateTime? orderTime;
  double unitPrice;
  int orderCount;
  double orderTotalPrice;
  int orderState;
  String orderPayWay;
  String orderRemark;
  String orderUserId;
  DateTime? payTime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
  orderId: json["OrderID"],
  orderName: json["OrderName"],
  orderTime: json["OrderTime"] == null ? null : DateTime.parse(json["OrderTime"]),
  unitPrice: json["UnitPrice"].toDouble(),
    orderCount: json["OrderCount"],
    orderTotalPrice: json["OrderTotalPrice"].toDouble(),
    orderState: json["OrderState"],
    orderPayWay: json["OrderPayWay"],
    orderRemark: json["OrderRemark"],
    orderUserId: json["OrderUserID"],
    payTime: json["PayTime"] == null ? null : DateTime.parse(json["PayTime"]),
  );

  Map<String, dynamic> toJson() => {
    "OrderID": orderId,
    "OrderName": orderName,
    "OrderTime": orderTime == null ? null : orderTime!.toIso8601String(),
    "UnitPrice": unitPrice,
    "OrderCount": orderCount,
    "OrderTotalPrice": orderTotalPrice,
    "OrderState": orderState,
    "OrderPayWay": orderPayWay,
    "OrderRemark": orderRemark,
    "OrderUserID": orderUserId,
    "PayTime": payTime == null ? null : payTime!.toIso8601String(),
  };
}