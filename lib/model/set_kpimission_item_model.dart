// To parse this JSON data, do
//
//     final selectItem = selectItemFromJson(jsonString);

import 'dart:convert';

SelectItem selectItemFromJson(String str) => SelectItem.fromJson(json.decode(str));

String selectItemToJson(SelectItem data) => json.encode(data.toJson());

class SelectItem {
  SelectItem({
    this.id,
    this.taskTitle,
    this.taskUnit,
  });

  String id;
  String taskTitle;
  String taskUnit;

  factory SelectItem.fromJson(Map<String, dynamic> json) => SelectItem(
    id: json["id"] == null ? null : json["id"],
    taskTitle: json["TaskTitle"] == null ? null : json["TaskTitle"],
    taskUnit: json["TaskUnit"] == null ? null : json["TaskUnit"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "TaskTitle": taskTitle == null ? null : taskTitle,
    "TaskUnit": taskUnit == null ? null : taskUnit,
  };
}