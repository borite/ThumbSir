// To parse this JSON data, do
//
//     final selectItem = selectItemFromJson(jsonString);

import 'dart:convert';

SelectItem selectItemFromJson(String str) => SelectItem.fromJson(json.decode(str));

String selectItemToJson(SelectItem data) => json.encode(data.toJson());

class SelectItem {
  SelectItem({
    required this.id,
    required this.taskTitle,
    required this.taskUnit,
  });

  String id;
  String taskTitle;
  String taskUnit;

  factory SelectItem.fromJson(Map<String, dynamic> json) => SelectItem(
    id: json["ID"],
    taskTitle: json["TaskTitle"],
    taskUnit: json["TaskUnit"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "TaskTitle": taskTitle,
    "TaskUnit": taskUnit,
  };
}