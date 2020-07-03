// To parse this JSON data, do
//
//     final chooseItem = chooseItemFromJson(jsonString);

import 'dart:convert';

ChooseItem chooseItemFromJson(String str) => ChooseItem.fromJson(json.decode(str));

String chooseItemToJson(ChooseItem data) => json.encode(data.toJson());

class ChooseItem {
  ChooseItem({
    this.id,
    this.taskTitle,
    this.taskUnit,
  });

  String id;
  String taskTitle;
  String taskUnit;

  factory ChooseItem.fromJson(Map<String, dynamic> json) => ChooseItem(
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