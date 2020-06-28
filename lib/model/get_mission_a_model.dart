// To parse this JSON data, do
//
//     final getMissionA = getMissionAFromJson(jsonString);

import 'dart:convert';

GetMissionA getMissionAFromJson(String str) => GetMissionA.fromJson(json.decode(str));

String getMissionAToJson(GetMissionA data) => json.encode(data.toJson());

class GetMissionA {
  GetMissionA({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  Data data;

  factory GetMissionA.fromJson(Map<String, dynamic> json) => GetMissionA(
    code: json["Code"] == null ? null : json["Code"],
    message: json["Message"] == null ? null : json["Message"],
    data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Code": code == null ? null : code,
    "Message": message == null ? null : message,
    "Data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.minCount,
    this.list,
  });

  List<int> minCount;
  List<ListElement> list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    minCount: json["minCount"] == null ? null : List<int>.from(json["minCount"].map((x) => x)),
    list: json["list"] == null ? null : List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "minCount": minCount == null ? null : List<dynamic>.from(minCount.map((x) => x)),
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    this.id,
    this.taskCount,
    this.taskTitle,
    this.taskUnit,
    this.taskContent,
  });

  int id;
  int taskCount;
  String taskTitle;
  String taskUnit;
  String taskContent;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["ID"] == null ? null : json["ID"],
    taskCount: json["TaskCount"] == null ? null : json["TaskCount"],
    taskTitle: json["TaskTitle"] == null ? null : json["TaskTitle"],
    taskUnit: json["TaskUnit"] == null ? null : json["TaskUnit"],
    taskContent: json["TaskContent"] == null ? null : json["TaskContent"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id == null ? null : id,
    "TaskCount": taskCount == null ? null : taskCount,
    "TaskTitle": taskTitle == null ? null : taskTitle,
    "TaskUnit": taskUnit == null ? null : taskUnit,
    "TaskContent": taskContent == null ? null : taskContent,
  };
}