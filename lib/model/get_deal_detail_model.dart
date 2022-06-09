// To parse this JSON data, do
//
//     final getDealDetail = getDealDetailFromJson(jsonString);

import 'dart:convert';

GetDealDetail getDealDetailFromJson(String str) => GetDealDetail.fromJson(json.decode(str));

String getDealDetailToJson(GetDealDetail data) => json.encode(data.toJson());

class GetDealDetail {
  GetDealDetail({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum>? data;

  factory GetDealDetail.fromJson(Map<String, dynamic> json) => GetDealDetail(
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
    this.finishTime,
    required this.dealReason,
    this.dealArea,
    required this.dealPrice,
    this.address,
    this.dealRemark,
  });

  int id;
  DateTime? finishTime;
  String dealReason;
  dynamic dealArea;
  double dealPrice;
  dynamic address;
  dynamic dealRemark;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["ID"] == null ? null : json["ID"],
    finishTime: json["FinishTime"] == null ? null : DateTime.parse(json["FinishTime"]),
    dealReason: json["DealReason"] == null ? null : json["DealReason"],
    dealArea: json["DealArea"],
    dealPrice: json["DealPrice"] == null ? null : json["DealPrice"],
    address: json["Address"],
    dealRemark: json["DealRemark"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "FinishTime": finishTime == null ? null : finishTime!.toIso8601String(),
    "DealReason": dealReason,
    "DealArea": dealArea,
    "DealPrice": dealPrice,
    "Address": address,
    "DealRemark": dealRemark,
  };
}
