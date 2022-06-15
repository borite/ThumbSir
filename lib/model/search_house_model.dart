// To parse this JSON data, do
//
//     final searchHouse = searchHouseFromJson(jsonString);

import 'dart:convert';

SearchHouse searchHouseFromJson(String str) => SearchHouse.fromJson(json.decode(str));

String searchHouseToJson(SearchHouse data) => json.encode(data.toJson());

class SearchHouse {
  SearchHouse({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum>? data;

  factory SearchHouse.fromJson(Map<String, dynamic> json) => SearchHouse(
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
    required this.houseId,
    this.houseCommunity,
    this.houseType,
    this.tradeType,
    this.houseArea,
    this.housePrice,
    this.houseAddress,
    this.addTime,
    this.tradeLevel,
    this.inputUser,
    this.maintenanceUser,
    this.fieldUser,
    this.keyUser,
    this.dealUser,
    this.exclusiveUser,
    this.houseInfo,
    this.houseNum,
    this.houseAroundInfo,
  });

  int houseId;
  dynamic houseCommunity;
  dynamic houseType;
  dynamic tradeType;
  dynamic houseArea;
  dynamic housePrice;
  dynamic houseAddress;
  DateTime? addTime;
  dynamic tradeLevel;
  dynamic inputUser;
  dynamic maintenanceUser;
  dynamic fieldUser;
  dynamic keyUser;
  dynamic dealUser;
  dynamic exclusiveUser;
  List<HouseInfo>? houseInfo;
  dynamic houseNum;
  List<HouseAroundInfo>? houseAroundInfo;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
  houseId: json["HouseID"],
  houseCommunity: json["HouseCommunity"],
  houseType: json["HouseType"],
  tradeType: json["TradeType"],
  houseArea: json["HouseArea"],
    housePrice: json["HousePrice"],
    houseAddress: json["HouseAddress"],
    addTime: DateTime.parse(json["AddTime"]),
    tradeLevel: json["TradeLevel"],
    inputUser: User.fromJson(json["InputUser"]),
    maintenanceUser: User.fromJson(json["MaintenanceUser"]),
    fieldUser: json["FieldUser"],
    keyUser: json["KeyUser"],
    dealUser: json["DealUser"],
    exclusiveUser: json["ExclusiveUser"],
    houseInfo: List<HouseInfo>.from(json["houseInfo"].map((x) => HouseInfo.fromJson(x))),
    houseNum: json["HouseNum"],
    houseAroundInfo: List<HouseAroundInfo>.from(json["houseAroundInfo"].map((x) => HouseAroundInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "HouseID": houseId,
    "HouseCommunity": houseCommunity,
    "HouseType": houseType,
    "TradeType": tradeType,
    "HouseArea": houseArea,
    "HousePrice": housePrice,
    "HouseAddress": houseAddress,
    "AddTime": addTime!.toIso8601String(),
    "TradeLevel": tradeLevel,
    "InputUser": inputUser.toJson(),
    "MaintenanceUser": maintenanceUser.toJson(),
    "FieldUser": fieldUser,
    "KeyUser": keyUser,
    "DealUser": dealUser,
    "ExclusiveUser": exclusiveUser,
    "houseInfo": List<dynamic>.from(houseInfo!.map((x) => x.toJson())),
    "HouseNum": houseNum,
    "houseAroundInfo": List<dynamic>.from(houseAroundInfo!.map((x) => x.toJson())),
  };
}

class HouseAroundInfo {
  HouseAroundInfo({
    this.hospital,
    this.isInSchoolArea,
    this.park,
    this.school,
    this.traffic,
    this.otherIntro,
    this.otherLabel,
    this.bank,
    this.entertainment,
  });

  dynamic hospital;
  dynamic isInSchoolArea;
  dynamic park;
  dynamic school;
  dynamic traffic;
  dynamic otherIntro;
  dynamic otherLabel;
  dynamic bank;
  dynamic entertainment;

  factory HouseAroundInfo.fromJson(Map<String, dynamic> json) => HouseAroundInfo(
    hospital: json["Hospital"],
    isInSchoolArea: json["IsInSchoolArea"],
    park: json["Park"],
    school: json["School"],
    traffic: json["Traffic"],
    otherIntro: json["OtherIntro"],
    otherLabel: json["OtherLabel"],
    bank: json["Bank"],
    entertainment: json["Entertainment"],
  );

  Map<String, dynamic> toJson() => {
    "Hospital": hospital,
    "IsInSchoolArea": isInSchoolArea,
    "Park": park,
    "School": school,
    "Traffic": traffic,
    "OtherIntro": otherIntro,
    "OtherLabel": otherLabel,
    "Bank": bank,
    "Entertainment": entertainment,
  };
}

class HouseInfo {
  HouseInfo({
    this.area,
    this.totalFloor,
    this.floor,
    this.orientation,
    this.housePlan,
    this.houseImages,
    this.structure,
    this.tax,
    this.decoration,
  });

  dynamic area;
  dynamic totalFloor;
  dynamic floor;
  dynamic orientation;
  dynamic housePlan;
  dynamic houseImages;
  dynamic structure;
  dynamic tax;
  dynamic decoration;

  factory HouseInfo.fromJson(Map<String, dynamic> json) => HouseInfo(
    area: json["Area"],
    totalFloor: json["TotalFloor"],
    floor: json["Floor"],
    orientation: json["Orientation"],
    housePlan: json["HousePlan"],
    houseImages: json["HouseImages"],
    structure: json["Structure"],
    tax: json["Tax"],
    decoration: json["Decoration"],
  );

  Map<String, dynamic> toJson() => {
    "Area": area,
    "TotalFloor": totalFloor,
    "Floor": floor,
    "Orientation": orientation,
    "HousePlan": housePlan,
    "HouseImages": houseImages,
    "Structure": structure,
    "Tax": tax,
    "Decoration": decoration,
  };
}

class User {
  User({
    this.userPid,
    this.userName,
  });

  dynamic userPid;
  dynamic userName;

  factory User.fromJson(Map<String, dynamic> json) => User(
  userPid: json["UserPID"],
    userName: json["UserName"],
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid,
    "UserName": userName,
  };
}