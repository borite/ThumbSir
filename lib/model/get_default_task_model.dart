// To parse this JSON data, do
//
//     final getDefaultTask = getDefaultTaskFromJson(jsonString);

import 'dart:convert';

GetDefaultTask getDefaultTaskFromJson(String str) => GetDefaultTask.fromJson(json.decode(str));

String getDefaultTaskToJson(GetDefaultTask data) => json.encode(data.toJson());

class GetDefaultTask {
  GetDefaultTask({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum> data;

  factory GetDefaultTask.fromJson(Map<String, dynamic> json) => GetDefaultTask(
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
    this.taskName,
    this.taskDesc,
    this.taskUnit,
  });

  int id;
  String taskName;
  TaskDesc taskDesc;
  String taskUnit;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["ID"] == null ? null : json["ID"],
    taskName: json["TaskName"] == null ? null : json["TaskName"],
    taskDesc: json["TaskDesc"] == null ? null : taskDescValues.map[json["TaskDesc"]],
    taskUnit: json["TaskUnit"] == null ? null : json["TaskUnit"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id == null ? null : id,
    "TaskName": taskName == null ? null : taskName,
    "TaskDesc": taskDesc == null ? null : taskDescValues.reverse[taskDesc],
    "TaskUnit": taskUnit == null ? null : taskUnit,
  };
}

enum TaskDesc { EMPTY, STRING }

final taskDescValues = EnumValues({
  "这里是一个描述": TaskDesc.EMPTY,
  "string": TaskDesc.STRING
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}