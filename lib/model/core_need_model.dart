// To parse this JSON data, do
//
//     final otherNeeds = otherNeedsFromJson(jsonString);

import 'dart:convert';

CoreNeeds coreNeedsFromJson(String str) => CoreNeeds.fromJson(json.decode(str));

String coreNeedsToJson(CoreNeeds data) => json.encode(data.toJson());

class CoreNeeds {
  CoreNeeds({
    this.elevator,
    this.floor,
    this.houseage,
    this.decoration,
    this.traffic,
    this.school,
    this.hospital,
    this.bank,
    this.park,
    this.shop,
    this.property,
    this.tax,
    this.special,
    this.other,
    this.area,
    this.room,
    this.direction,
  });

  String elevator;
  String floor;
  String houseage;
  String decoration;
  String traffic;
  String school;
  String hospital;
  String bank;
  String park;
  String shop;
  String property;
  String tax;
  String special;
  String other;
  String area;
  String room;
  String direction;

  factory CoreNeeds.fromJson(Map<String, dynamic> json) => CoreNeeds(
    elevator: json["elevator"] == null ? null : json["elevator"],
    floor: json["floor"] == null ? null : json["floor"],
    houseage: json["houseage"] == null ? null : json["houseage"],
    decoration: json["decoration"] == null ? null : json["decoration"],
    traffic: json["traffic"] == null ? null : json["traffic"],
    school: json["school"] == null ? null : json["school"],
    hospital: json["hospital"] == null ? null : json["hospital"],
    bank: json["bank"] == null ? null : json["bank"],
    park: json["park"] == null ? null : json["park"],
    shop: json["shop"] == null ? null : json["shop"],
    property: json["property"] == null ? null : json["property"],
    tax: json["tax"] == null ? null : json["tax"],
    special: json["special"] == null ? null : json["special"],
    other: json["other"] == null ? null : json["other"],
    area: json["area"] == null ? null : json["area"],
    room: json["room"] == null ? null : json["room"],
    direction: json["direction"] == null ? null : json["direction"],
  );

  Map<String, dynamic> toJson() => {
    "elevator": elevator == null ? null : elevator,
    "floor": floor == null ? null : floor,
    "houseage": houseage == null ? null : houseage,
    "decoration": decoration == null ? null : decoration,
    "traffic": traffic == null ? null : traffic,
    "school": school == null ? null : school,
    "hospital": hospital == null ? null : hospital,
    "bank": bank == null ? null : bank,
    "park": park == null ? null : park,
    "shop": shop == null ? null : shop,
    "property": property == null ? null : property,
    "tax": tax == null ? null : tax,
    "special": special == null ? null : special,
    "other": other == null ? null : other,
    "area": area == null ? null : area,
    "room": room == null ? null : room,
    "direction": direction == null ? null : direction,
  };
}
