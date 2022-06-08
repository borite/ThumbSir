// To parse this JSON data, do
//
//     final getNeedsDetail = getNeedsDetailFromJson(jsonString);

import 'dart:convert';

GetNeedsDetail getNeedsDetailFromJson(String str) => GetNeedsDetail.fromJson(json.decode(str));

String getNeedsDetailToJson(GetNeedsDetail data) => json.encode(data.toJson());

class GetNeedsDetail {
  GetNeedsDetail({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum> data;

  factory GetNeedsDetail.fromJson(Map<String, dynamic> json) => GetNeedsDetail(
    code: json["Code"] == null ? null : json["Code"],
    message: json["Message"] == null ? null : json["Message"],
    data: json["Data"] == null ? null : List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Code": code == null ? null : code,
    "Message": message == null ? null : message,
    "Data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.mainNeed,
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
    this.state,
  });

  int id;
  String mainNeed;
  String needReason;
  String coreNeedOne;
  String coreNeedOneRemark;
  String coreNeedTwo;
  String coreNeedTwoRemark;
  String coreNeedThree;
  String coreNeedThreeRemark;
  String otherNeed;
  String otherNeedRemark;
  String addTime;
  int state;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
  id: json["ID"] == null ? null : json["ID"],
  mainNeed: json["MainNeed"] == null ? null : json["MainNeed"],
  needReason: json["NeedReason"] == null ? null : json["NeedReason"],
    coreNeedOne: json["CoreNeedOne"] == null ? null : json["CoreNeedOne"],
    coreNeedOneRemark: json["CoreNeedOneRemark"] == null ? null : json["CoreNeedOneRemark"],
    coreNeedTwo: json["CoreNeedTwo"] == null ? null : json["CoreNeedTwo"],
    coreNeedTwoRemark: json["CoreNeedTwoRemark"] == null ? null : json["CoreNeedTwoRemark"],
    coreNeedThree: json["CoreNeedThree"] == null ? null : json["CoreNeedThree"],
    coreNeedThreeRemark: json["CoreNeedThreeRemark"] == null ? null : json["CoreNeedThreeRemark"],
    otherNeed: json["OtherNeed"] == null ? null : json["OtherNeed"],
    otherNeedRemark: json["OtherNeedRemark"] == null ? null : json["OtherNeedRemark"],
    addTime: json["AddTime"] == null ? null : json["AddTime"],
    state: json["State"] == null ? null : json["State"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id == null ? null : id,
    "MainNeed": mainNeed == null ? null : mainNeed,
    "NeedReason": needReason == null ? null : needReason,
    "CoreNeedOne": coreNeedOne == null ? null : coreNeedOne,
    "CoreNeedOneRemark": coreNeedOneRemark == null ? null : coreNeedOneRemark,
    "CoreNeedTwo": coreNeedTwo == null ? null : coreNeedTwo,
    "CoreNeedTwoRemark": coreNeedTwoRemark == null ? null : coreNeedTwoRemark,
    "CoreNeedThree": coreNeedThree == null ? null : coreNeedThree,
    "CoreNeedThreeRemark": coreNeedThreeRemark == null ? null : coreNeedThreeRemark,
    "OtherNeed": otherNeed == null ? null : otherNeed,
    "OtherNeedRemark": otherNeedRemark == null ? null : otherNeedRemark,
    "AddTime": addTime == null ? null : addTime,
    "State": state == null ? null : state,
  };
}