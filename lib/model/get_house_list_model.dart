// To parse this JSON data, do
//
//     final getHouseList = getHouseListFromJson(jsonString);

import 'dart:convert';

GetHouseList getHouseListFromJson(String str) => GetHouseList.fromJson(json.decode(str));

String getHouseListToJson(GetHouseList data) => json.encode(data.toJson());

class GetHouseList {
  GetHouseList({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum>? data;

  factory GetHouseList.fromJson(Map<String, dynamic> json) => GetHouseList(
    code: json["Code"] == null ? null : json["Code"],
    message: json["Message"] == null ? null : json["Message"],
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
    required this.houseId,
    required this.houseCommunity,
    required this.houseType,
    required this.tradeType,
    this.houseArea,
    required this.housePrice,
    this.houseAddress,
    this.addTime,
    this.tradeLevel,
    this.houseOwnerShip,
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
  String houseCommunity;
  String houseType;
  String tradeType;
  dynamic houseArea;
  double housePrice;
  dynamic houseAddress;
  DateTime? addTime;
  dynamic tradeLevel;
  dynamic houseOwnerShip;
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
    houseId: json["HouseID"] == null ? null : json["HouseID"],
    houseCommunity: json["HouseCommunity"] == null ? null : json["HouseCommunity"],
    houseType: json["HouseType"] == null ? null : json["HouseType"],
    tradeType: json["TradeType"] == null ? null : json["TradeType"],
    houseArea: json["HouseArea"] == null ? null : json["HouseArea"],
    housePrice: json["HousePrice"] == null ? null : json["HousePrice"].toDouble(),
    houseAddress: json["HouseAddress"] == null ? null : json["HouseAddress"],
    addTime: json["AddTime"] == null ? null : DateTime.parse(json["AddTime"]),
    tradeLevel: json["TradeLevel"] == null ? null : json["TradeLevel"],
    houseOwnerShip: json["HouseOwnerShip"] == null ? null : json["HouseOwnerShip"],
    inputUser: json["InputUser"] == null ? null : User.fromJson(json["InputUser"]),
    maintenanceUser: json["MaintenanceUser"] == null ? null : User.fromJson(json["MaintenanceUser"]),
    fieldUser: json["FieldUser"] == null ? null : User.fromJson(json["FieldUser"]),
    keyUser: json["KeyUser"] == null ? null : User.fromJson(json["KeyUser"]),
    dealUser: json["DealUser"] == null ? null : User.fromJson(json["DealUser"]),
    exclusiveUser: json["ExclusiveUser"] == null ? null : User.fromJson(json["ExclusiveUser"]),
    houseInfo: json["houseInfo"] == null ? null : List<HouseInfo>.from(json["houseInfo"].map((x) => HouseInfo.fromJson(x))),
    houseNum: json["houseNum"] == null ? null : json["houseNum"],
    houseAroundInfo: json["houseAroundInfo"] == null ? null : List<HouseAroundInfo>.from(json["houseAroundInfo"].map((x) => HouseAroundInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
  "HouseID": houseId,
  "HouseCommunity": houseCommunity,
  "HouseType": houseType,
  "TradeType": tradeType,
  "HouseArea": houseArea == null ? null : houseArea,
  "HousePrice": housePrice,
  "HouseAddress": houseAddress == null ? null : houseAddress,
    "AddTime": addTime == null ? null : addTime!.toIso8601String(),
    "TradeLevel": tradeLevel == null ? null : tradeLevel,
    "HouseOwnerShip": houseOwnerShip == null ? null : houseOwnerShip,
    "InputUser": inputUser == null ? null : inputUser.toJson(),
    "MaintenanceUser": maintenanceUser == null ? null : maintenanceUser.toJson(),
    "FieldUser": fieldUser == null ? null : fieldUser.toJson(),
    "KeyUser": keyUser == null ? null : keyUser.toJson(),
    "DealUser": dealUser == null ? null : dealUser.toJson(),
    "ExclusiveUser": exclusiveUser == null ? null : exclusiveUser.toJson(),
    "houseInfo": houseInfo == null ? null : List<dynamic>.from(houseInfo!.map((x) => x.toJson())),
    "houseNum": houseNum == null ? null : houseNum,
    "houseAroundInfo": houseAroundInfo == null ? null : List<dynamic>.from(houseAroundInfo!.map((x) => x.toJson())),
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
    hospital: json["Hospital"] == null ? null : json["Hospital"],
    isInSchoolArea: json["IsInSchoolArea"] == null ? null : json["IsInSchoolArea"],
    park: json["Park"] == null ? null : json["Park"],
    school: json["School"] == null ? null : json["School"],
    traffic: json["Traffic"] == null ? null : json["Traffic"],
    otherIntro: json["OtherIntro"] == null ? null : json["OtherIntro"],
    otherLabel: json["OtherLabel"] == null ? null : json["OtherLabel"],
    bank: json["Bank"] == null ? null : json["Bank"],
    entertainment: json["Entertainment"] == null ? null : json["Entertainment"],
  );

  Map<String, dynamic> toJson() => {
    "Hospital": hospital == null ? null : hospital,
    "IsInSchoolArea": isInSchoolArea == null ? null : isInSchoolArea,
    "Park": park == null ? null : park,
    "School": school == null ? null : school,
    "Traffic": traffic == null ? null : traffic,
    "OtherIntro": otherIntro == null ? null : otherIntro,
    "OtherLabel": otherLabel == null ? null : otherLabel,
    "Bank": bank == null ? null : bank,
    "Entertainment": entertainment == null ? null : entertainment,
  };
}

class HouseInfo {
  HouseInfo({
    this.area,
    this.totalFloor,
    this.floor,
    this.orientation,
    this.houseImages,
    this.housePlan,
    this.structure,
    this.tax,
    this.decoration,
  });

  dynamic area;
  dynamic totalFloor;
  dynamic floor;
  dynamic orientation;
  dynamic houseImages;
  dynamic housePlan;
  dynamic structure;
  dynamic tax;
  dynamic decoration;

  factory HouseInfo.fromJson(Map<String, dynamic> json) => HouseInfo(
    area: json["Area"] == null ? null : json["Area"].toDouble(),
    totalFloor: json["TotalFloor"] == null ? null : json["TotalFloor"],
    floor: json["Floor"] == null ? null : json["Floor"],
    orientation: json["Orientation"] == null ? null : json["Orientation"],
    houseImages: json["HouseImages"] == null ? null : json["HouseImages"],
    housePlan: json["HousePlan"] == null ? null : json["HousePlan"],
    structure: json["Structure"] == null ? null : json["Structure"],
    tax: json["Tax"] == null ? null : json["Tax"],
    decoration: json["Decoration"] == null ? null : json["Decoration"],
  );

  Map<String, dynamic> toJson() => {
  "Area": area == null ? null : area,
  "TotalFloor": totalFloor == null ? null : totalFloor,
  "Floor": floor == null ? null : floor,
  "Orientation": orientation == null ? null : orientation,
    "HouseImages": houseImages == null ? null : houseImages,
    "HousePlan": housePlan == null ? null : housePlan,
  "Structure": structure == null ? null : structure,
    "Tax": tax == null ? null : tax,
    "Decoration": decoration == null ? null : decoration,
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
    userPid: json["UserPID"] == null ? null : json["UserPID"],
    userName: json["UserName"] == null ? null : json["UserName"],
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid == null ? null : userPid,
    "UserName": userName == null ? null : userName,
  };
}