// To parse this JSON data, do
//
//     final chooseItem = chooseItemFromJson(jsonString);

import 'dart:convert';

ChooseItem chooseItemFromJson(String str) => ChooseItem.fromJson(json.decode(str));

String chooseItemToJson(ChooseItem data) => json.encode(data.toJson());

class ChooseItem {
  ChooseItem({
    required this.id,
    required this.taskTitle,
    required this.taskUnit,
  });

  String id;
  String taskTitle;
  String taskUnit;

  factory ChooseItem.fromJson(Map<String, dynamic> json) => ChooseItem(
    id: json["id"],
    taskTitle: json["TaskTitle"],
    taskUnit: json["TaskUnit"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "TaskTitle": taskTitle,
    "TaskUnit": taskUnit,
  };
}