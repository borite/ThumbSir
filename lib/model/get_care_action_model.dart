// To parse this JSON data, do
//
//     final getCareAction = getCareActionFromJson(jsonString);

import 'dart:convert';

GetCareAction getCareActionFromJson(String str) => GetCareAction.fromJson(json.decode(str));

String getCareActionToJson(GetCareAction data) => json.encode(data.toJson());

class GetCareAction {
  GetCareAction({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum>? data;

  factory GetCareAction.fromJson(Map<String, dynamic> json) => GetCareAction(
    code: json["Code"] == null ? null : json["Code"],
    message: json["Message"] == null ? null : json["Message"],
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
    required this.id,
    required this.giftName,
    required this.giftReason,
    required this.giftPrice,
    this.addTime,
    required this.giftRemark,
  });

  int id;
  String giftName;
  String giftReason;
  double giftPrice;
  DateTime? addTime;
  String giftRemark;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["ID"] == null ? null : json["ID"],
    giftName: json["GiftName"] == null ? null : json["GiftName"],
    giftReason: json["GiftReason"] == null ? null : json["GiftReason"],
    giftPrice: json["GiftPrice"] == null ? null : json["GiftPrice"],
    addTime: json["AddTime"] == null ? null : DateTime.parse(json["AddTime"]),
    giftRemark: json["GiftRemark"] == null ? null : json["GiftRemark"],
  );

  Map<String, dynamic> toJson() => {
  "ID": id,
  "GiftName": giftName,
  "GiftReason": giftReason,
    "GiftPrice": giftPrice,
    "AddTime": addTime == null ? null : addTime!.toIso8601String(),
    "GiftRemark": giftRemark,
  };
}