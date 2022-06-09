// To parse this JSON data, do
//
//     final shangQuanPayFor = shangQuanPayForFromJson(jsonString);

import 'dart:convert';

ShangQuanPayFor shangQuanPayForFromJson(String str) => ShangQuanPayFor.fromJson(json.decode(str));

String shangQuanPayForToJson(ShangQuanPayFor data) => json.encode(data.toJson());

class ShangQuanPayFor {
  ShangQuanPayFor({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory ShangQuanPayFor.fromJson(Map<String, dynamic> json) => ShangQuanPayFor(
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
    this.shangQuanBuyExtInfos,
    required this.sQpay,
  });

  List<ShangQuanBuyExtInfo>? shangQuanBuyExtInfos;
  double sQpay;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    shangQuanBuyExtInfos: json["shangQuanBuyExtInfos"] == null ? null : List<ShangQuanBuyExtInfo>.from(json["shangQuanBuyExtInfos"].map((x) => ShangQuanBuyExtInfo.fromJson(x))),
    sQpay: json["SQpay"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "shangQuanBuyExtInfos": shangQuanBuyExtInfos == null ? null : List<dynamic>.from(shangQuanBuyExtInfos!.map((x) => x.toJson())),
    "SQpay": sQpay,
  };
}

class ShangQuanBuyExtInfo {
  ShangQuanBuyExtInfo({
    required this.userId,
    required this.userName,
    required this.boughtVip,
    required this.boughtVipDiffDays,
    required this.memberCount,
    required this.buyExtNum,
    required this.buyExtSeatFee,
    required this.totalMoney,
  });

  String userId;
  String userName;
  int boughtVip;
  int boughtVipDiffDays;
  int memberCount;
  int buyExtNum;
  double buyExtSeatFee;
  double totalMoney;

  factory ShangQuanBuyExtInfo.fromJson(Map<String, dynamic> json) => ShangQuanBuyExtInfo(
    userId: json["UserID"],
    userName: json["UserName"],
    boughtVip: json["BoughtVIP"],
    boughtVipDiffDays: json["BoughtVipDiffDays"],
    memberCount: json["MemberCount"],
    buyExtNum: json["BuyExtNum"],
    buyExtSeatFee: json["BuyExtSeatFee"].toDouble(),
    totalMoney: json["TotalMoney"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "UserID": userId,
    "UserName": userName,
    "BoughtVIP": boughtVip,
    "BoughtVipDiffDays": boughtVipDiffDays,
    "MemberCount": memberCount,
    "BuyExtNum": buyExtNum,
    "BuyExtSeatFee": buyExtSeatFee,
    "TotalMoney": totalMoney,
  };
}