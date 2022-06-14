// To parse this JSON data, do
//
//     final getNeedsDetail = getNeedsDetailFromJson(jsonString);

import 'dart:convert';

GetNeedsDetail getNeedsDetailFromJson(String str) => GetNeedsDetail.fromJson(json.decode(str));

String getNeedsDetailToJson(GetNeedsDetail data) => json.encode(data.toJson());

class GetNeedsDetail {
  GetNeedsDetail({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum>? data;

  factory GetNeedsDetail.fromJson(Map<String, dynamic> json) => GetNeedsDetail(
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
    required this.mainNeed,
    this.needReason,
    this.coreNeedOne,
    this.coreNeedOneRemark,
    this.coreNeedTwo,
    this.coreNeedTwoRemark,
    this.coreNeedThree,
    this.coreNeedThreeRemark,
    this.otherNeed,
    this.otherNeedRemark,
    this.addTime,
    required this.state,
  });

  int id;
  String mainNeed;
  dynamic needReason;
  dynamic coreNeedOne;
  dynamic coreNeedOneRemark;
  dynamic coreNeedTwo;
  dynamic coreNeedTwoRemark;
  dynamic coreNeedThree;
  dynamic coreNeedThreeRemark;
  dynamic otherNeed;
  dynamic otherNeedRemark;
  DateTime? addTime;
  int state;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
  id: json["ID"] == null ? null : json["ID"],
  mainNeed: json["MainNeed"] == null ? null : json["MainNeed"],
  needReason: json["NeedReason"],
  coreNeedOne: json["CoreNeedOne"],
  coreNeedOneRemark: json["CoreNeedOneRemark"],
    coreNeedTwo: json["CoreNeedTwo"],
    coreNeedTwoRemark: json["CoreNeedTwoRemark"],
    coreNeedThree: json["CoreNeedThree"],
    coreNeedThreeRemark: json["CoreNeedThreeRemark"],
    otherNeed: json["OtherNeed"],
    otherNeedRemark: json["OtherNeedRemark"],
    addTime: json["AddTime"] == null ? null : DateTime.parse(json["AddTime"]),
    state: json["State"] == null ? null : json["State"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "MainNeed": mainNeed,
    "NeedReason": needReason,
    "CoreNeedOne": coreNeedOne,
    "CoreNeedOneRemark": coreNeedOneRemark,
    "CoreNeedTwo": coreNeedTwo,
    "CoreNeedTwoRemark": coreNeedTwoRemark,
    "CoreNeedThree": coreNeedThree,
    "CoreNeedThreeRemark": coreNeedThreeRemark,
    "OtherNeed": otherNeed,
    "OtherNeedRemark": otherNeedRemark,
    "AddTime": addTime == null ? null : addTime!.toIso8601String(),
    "State": state,
  };
}