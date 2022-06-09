// To parse this JSON data, do
//
//     final getMissionA = getMissionAFromJson(jsonString);

import 'dart:convert';

GetMissionA getMissionAFromJson(String str) => GetMissionA.fromJson(json.decode(str));

String getMissionAToJson(GetMissionA data) => json.encode(data.toJson());

class GetMissionA {
  GetMissionA({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory GetMissionA.fromJson(Map<String, dynamic> json) => GetMissionA(
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
    required this.minCount,
    this.list,
  });

  int minCount;
  List<ListElement>? list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    minCount: json["minCount"],
    list: json["list"] == null ? null : List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "minCount": minCount,
    "list": list == null ? null : List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    required this.id,
    required this.taskCount,
    required this.taskTitle,
    required this.taskUnit,
    this.taskContent,
  });

  int id;
  int taskCount;
  String taskTitle;
  String taskUnit;
  dynamic taskContent;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["ID"],
    taskCount: json["TaskCount"],
    taskTitle: json["TaskTitle"],
    taskUnit: json["TaskUnit"],
    taskContent: json["TaskContent"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "TaskCount": taskCount,
    "TaskTitle": taskTitle,
    "TaskUnit": taskUnit,
    "TaskContent": taskContent,
  };
}
