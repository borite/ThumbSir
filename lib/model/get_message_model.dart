// To parse this JSON data, do
//
//     final getMessage = getMessageFromJson(jsonString);

import 'dart:convert';

GetMessage getMessageFromJson(String str) => GetMessage.fromJson(json.decode(str));

String getMessageToJson(GetMessage data) => json.encode(data.toJson());

class GetMessage {
  GetMessage({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum> data;

  factory GetMessage.fromJson(Map<String, dynamic> json) => GetMessage(
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
    this.msgTitle,
    this.msgContent,
    this.msgType,
    this.sendTime,
    this.state,
  });

  int id;
  String msgTitle;
  String msgContent;
  int msgType;
  DateTime sendTime;
  int state;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["ID"] == null ? null : json["ID"],
    msgTitle: json["MsgTitle"] == null ? null : json["MsgTitle"],
    msgContent: json["MsgContent"] == null ? null : json["MsgContent"],
    msgType: json["MsgType"] == null ? null : json["MsgType"],
    sendTime: json["SendTime"] == null ? null : DateTime.parse(json["SendTime"]),
    state: json["State"] == null ? null : json["State"],
  );

  Map<String, dynamic> toJson() => {
  "ID": id == null ? null : id,
  "MsgTitle": msgTitle == null ? null : msgTitle,
  "MsgContent": msgContent == null ? null : msgContent,
  "MsgType": msgType == null ? null : msgType,
    "SendTime": sendTime == null ? null : sendTime.toIso8601String(),
    "State": state == null ? null : state,
  };
}