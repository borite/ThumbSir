// To parse this JSON data, do
//
//     final dianZhangPayFor = dianZhangPayForFromJson(jsonString);

import 'dart:convert';

DianZhangPayFor dianZhangPayForFromJson(String str) => DianZhangPayFor.fromJson(json.decode(str));

String dianZhangPayForToJson(DianZhangPayFor data) => json.encode(data.toJson());

class DianZhangPayFor {
  DianZhangPayFor({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Data? data;

  factory DianZhangPayFor.fromJson(Map<String, dynamic> json) => DianZhangPayFor(
    code: json["Code"],
    message: json["Message"],
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
    required this.totalMoney,
    required this.buyCount,
    required this.memberCount,
    required this.payinfo,
  });

  double totalMoney;
  int buyCount;
  int memberCount;
  List<Payinfo>? payinfo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalMoney: json["totalMoney"],
    buyCount: json["buyCount"],
    memberCount: json["memberCount"],
    payinfo: json["payinfo"] == null ? null : List<Payinfo>.from(json["payinfo"].map((x) => Payinfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalMoney": totalMoney,
    "buyCount": buyCount,
    "memberCount": memberCount,
    "payinfo": payinfo == null ? null : List<dynamic>.from(payinfo!.map((x) => x.toJson())),
  };
}

class Payinfo {
  Payinfo({
  required this.uname,
  required this.endTime,
  required this.money,
  required this.days,
  required this.isVip,
  });

  String uname;
  DateTime? endTime;
  double money;
  int days;
  bool isVip;

  factory Payinfo.fromJson(Map<String, dynamic> json) => Payinfo(
    uname: json["Uname"],
    endTime: json["EndTime"] == null ? null : DateTime.parse(json["EndTime"]),
    money: json["Money"].toDouble(),
    days: json["days"],
    isVip: json["IsVip"],
  );

  Map<String, dynamic> toJson() => {
    "Uname": uname,
    "EndTime": endTime == null ? null : endTime!.toIso8601String(),
    "Money": money,
    "days": days,
    "IsVip": isVip,
  };
}