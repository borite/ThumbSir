// To parse this JSON data, do
//
//     final sellOtherNeeds = sellOtherNeedsFromJson(jsonString);

import 'dart:convert';

SellOtherNeeds sellOtherNeedsFromJson(String str) => SellOtherNeeds.fromJson(json.decode(str));

String sellOtherNeedsToJson(SellOtherNeeds data) => json.encode(data.toJson());

class SellOtherNeeds {
  SellOtherNeeds({
    this.buyWay,
    this.dingJin,
    this.shouFu,
    this.zhouQi,
    this.other,
  });

  String buyWay;
  String dingJin;
  String shouFu;
  String zhouQi;
  String other;

  factory SellOtherNeeds.fromJson(Map<String, dynamic> json) => SellOtherNeeds(
    buyWay: json["buyWay"] == null ? null : json["buyWay"],
    dingJin: json["dingJin"] == null ? null : json["dingJin"],
    shouFu: json["shouFu"] == null ? null : json["shouFu"],
    zhouQi: json["zhouQi"] == null ? null : json["zhouQi"],
    other: json["other"] == null ? null : json["other"],
  );

  Map<String, dynamic> toJson() => {
    "buyWay": buyWay == null ? null : buyWay,
    "dingJin": dingJin == null ? null : dingJin,
    "shouFu": shouFu == null ? null : shouFu,
    "zhouQi": zhouQi == null ? null : zhouQi,
    "other": other == null ? null : other,
  };
}