// To parse this JSON data, do
//
//     final houseListSearchInfo = houseListSearchInfoFromJson(jsonString);

import 'dart:convert';

HouseListSearchInfo houseListSearchInfoFromJson(String str) => HouseListSearchInfo.fromJson(json.decode(str));

String houseListSearchInfoToJson(HouseListSearchInfo data) => json.encode(data.toJson());

class HouseListSearchInfo {
  HouseListSearchInfo({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum>? data;

  factory HouseListSearchInfo.fromJson(Map<String, dynamic> json) => HouseListSearchInfo(
    code: json["Code"],
    message: json["Message"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.orientation,
    this.structure,
    this.area,
    this.houseNum,
    this.tradeType,
    this.houseType,
    this.housePrice,
    this.houseIntro,
    this.floor,
    this.totalFloor,
    this.decoration,
    this.houseAge,
    this.tradeLevel,
    this.hid,
    this.haveElevator,
    this.floorHigh,
    this.houseOwnership,
    this.houseDistrict,
    this.addTime,
    this.houseUnitPrice,
    this.inputUser,
    this.isInvalid,
    this.companyId,
    this.houseImages,
    this.dealUser,
    this.otherLabel,
    this.tax,
    this.isInSchoolArea,
    this.daiKanCount,
  });

  dynamic orientation;
  dynamic structure;
  dynamic area;
  dynamic houseNum;
  dynamic tradeType;
  dynamic houseType;
  dynamic housePrice;
  dynamic houseIntro;
  dynamic floor;
  dynamic totalFloor;
  dynamic decoration;
  dynamic houseAge;
  dynamic tradeLevel;
  dynamic hid;
  dynamic haveElevator;
  dynamic floorHigh;
  dynamic houseOwnership;
  dynamic houseDistrict;
  DateTime? addTime;
  dynamic houseUnitPrice;
  dynamic inputUser;
  dynamic isInvalid;
  dynamic companyId;
  dynamic houseImages;
  dynamic dealUser;
  dynamic otherLabel;
  dynamic tax;
  dynamic isInSchoolArea;
  dynamic daiKanCount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    orientation: json["Orientation"] == null ? null : json["Orientation"],
    structure: json["Structure"] == null ? null : json["Structure"],
    area: json["Area"] == null ? null : json["Area"],
    houseNum: json["HouseNum"],
    tradeType: json["TradeType"],
    houseType: json["HouseType"],
    housePrice: json["HousePrice"].toDouble(),
    houseIntro: json["HouseIntro"],
    floor: json["Floor"] == null ? null : json["Floor"],
    totalFloor: json["TotalFloor"] == null ? null : json["TotalFloor"],
    decoration: json["Decoration"] == null ? null : json["Decoration"],
    houseAge: json["HouseAge"] == null ? null : json["HouseAge"],
    tradeLevel: json["TradeLevel"],
    hid: json["HID"],
    haveElevator: json["HaveElevator"] == null ? null : json["HaveElevator"],
    floorHigh: json["FloorHigh"] == null ? null : json["FloorHigh"],
    houseOwnership: json["HouseOwnership"],
    houseDistrict: json["HouseDistrict"],
    addTime: DateTime.parse(json["AddTime"]),
    houseUnitPrice: json["HouseUnitPrice"],
    inputUser: json["InputUser"],
    isInvalid: json["IsInvalid"] == null ? null : json["IsInvalid"],
    companyId: json["CompanyID"],
    houseImages: json["HouseImages"] == null ? null : json["HouseImages"],
    dealUser: json["DealUser"] == null ? null : json["DealUser"],
    otherLabel: json["OtherLabel"],
    tax: json["Tax"],
    isInSchoolArea: json["IsInSchoolArea"],
    daiKanCount: json["DaiKanCount"],
  );

  Map<String, dynamic> toJson() => {
  "Orientation": orientation == null ? null : orientation,
    "Structure": structure == null ? null : structure,
    "Area": area == null ? null : area,
    "HouseNum": houseNum,
    "TradeType": tradeType,
    "HouseType": houseType,
    "HousePrice": housePrice,
    "HouseIntro": houseIntro,
    "Floor": floor == null ? null : floor,
    "TotalFloor": totalFloor == null ? null : totalFloor,
    "Decoration": decoration == null ? null : decoration,
    "HouseAge": houseAge == null ? null : houseAge,
    "TradeLevel": tradeLevel,
    "HID": hid,
    "HaveElevator": haveElevator == null ? null : haveElevator,
    "FloorHigh": floorHigh == null ? null : floorHigh,
    "HouseOwnership": houseOwnership,
    "HouseDistrict": houseDistrict,
    "AddTime": addTime!.toIso8601String(),
    "HouseUnitPrice": houseUnitPrice,
    "InputUser": inputUser,
    "IsInvalid": isInvalid == null ? null : isInvalid,
    "CompanyID": companyId,
    "HouseImages": houseImages == null ? null : houseImages,
    "DealUser": dealUser == null ? null : dealUser,
    "OtherLabel": otherLabel,
    "Tax": tax,
    "IsInSchoolArea": isInSchoolArea,
    "DaiKanCount": daiKanCount,
  };
}