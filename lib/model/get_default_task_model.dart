// To parse this JSON data, do
//
//     final getDefaultTask = getDefaultTaskFromJson(jsonString);

import 'dart:convert';

GetDefaultTask getDefaultTaskFromJson(String str) => GetDefaultTask.fromJson(json.decode(str));

String getDefaultTaskToJson(GetDefaultTask data) => json.encode(data.toJson());

class GetDefaultTask {
  GetDefaultTask({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum>? data;

  factory GetDefaultTask.fromJson(Map<String, dynamic> json) => GetDefaultTask(
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
    required this.taskName,
    this.taskDesc,
    required this.taskUnit,
  });

  int id;
  String taskName;
  TaskDesc? taskDesc;
  String taskUnit;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["ID"],
    taskName: json["TaskName"],
    taskDesc: json["TaskDesc"] == null ? null : taskDescValues.map![json["TaskDesc"]],
    taskUnit: json["TaskUnit"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "TaskName": taskName,
    "TaskDesc": taskDesc == null ? null : taskDescValues.reverse![taskDesc],
    "TaskUnit": taskUnit,
  };
}

enum TaskDesc { EMPTY, STRING }

final taskDescValues = EnumValues({
  "这里是一个描述": TaskDesc.EMPTY,
  "string": TaskDesc.STRING
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map?.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}