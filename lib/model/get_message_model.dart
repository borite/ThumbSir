// To parse this JSON data, do
//
//     final getMessage = getMessageFromJson(jsonString);

import 'dart:convert';

GetMessage getMessageFromJson(String str) => GetMessage.fromJson(json.decode(str));

String getMessageToJson(GetMessage data) => json.encode(data.toJson());

class GetMessage {
  GetMessage({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  List<Datum>? data;

  factory GetMessage.fromJson(Map<String, dynamic> json) => GetMessage(
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
    required this.id,
    required this.msgTitle,
    required this.msgContent,
    required this.msgType,
    required this.sendTime,
    required this.state,
    required this.fromUser,
  });

  int id;
  String msgTitle;
  String msgContent;
  int msgType;
  DateTime? sendTime;
  int? state;
  String? fromUser;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["ID"],
    msgTitle: json["MsgTitle"],
    msgContent: json["MsgContent"],
    msgType: json["MsgType"],
    sendTime: json["SendTime"] == null ? null : DateTime.parse(json["SendTime"]),
    state: json["State"],
    fromUser: json["FromUser"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "MsgTitle": msgTitle,
    "MsgContent": msgContent,
    "MsgType": msgType,
    "SendTime": sendTime?.toIso8601String(),
    "State": state,
    "FromUser": fromUser,
  };
}