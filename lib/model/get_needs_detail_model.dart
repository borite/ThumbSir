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
    this.state,
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
    state: json["State"] == null ? null : json["State"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id == null ? null : id,
    "MainNeed": mainNeed == null ? null : mainNeed,
    "NeedReason": needReason,
    "CoreNeedOne": coreNeedOne,
    "CoreNeedOneRemark": coreNeedOneRemark,
    "CoreNeedTwo": coreNeedTwo,
    "CoreNeedTwoRemark": coreNeedTwoRemark,
    "CoreNeedThree": coreNeedThree,
    "CoreNeedThreeRemark": coreNeedThreeRemark,
    "OtherNeed": otherNeed,
    "OtherNeedRemark": otherNeedRemark,
    "State": state == null ? null : state,
  };
}