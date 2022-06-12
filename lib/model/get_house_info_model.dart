// To parse this JSON data, do
//
//     final getHouseInfo = getHouseInfoFromJson(jsonString);

import 'dart:convert';

GetHouseInfo getHouseInfoFromJson(String str) => GetHouseInfo.fromJson(json.decode(str));

String getHouseInfoToJson(GetHouseInfo data) => json.encode(data.toJson());

class GetHouseInfo {
  GetHouseInfo({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum>? data;

  factory GetHouseInfo.fromJson(Map<String, dynamic> json) => GetHouseInfo(
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
    this.companyLh,
    this.houseBasicInfo,
    this.housePrivateInformation,
    this.userLh,
    this.userLh1,
    this.userLh2,
    this.userLh3,
    this.userLh4,
    this.userLh5,
    this.userInfoMain,
    this.houseImages,
    this.houseAroundInfo,
    required this.houseId,
    required this.companyId,
    required this.ownerId,
    this.tradeType,
    this.houseType,
    this.houseCommunity,
    this.houseAddress,
    this.tradeReason,
    this.houseFrom,
    this.housePrice,
    this.tradeLevel,
    this.inputUser,
    this.maintenanceUser,
    this.fieldUser,
    this.keyUser,
    this.dealUser,
    this.exclusiveUser,
    this.addTime,
    this.houseIntro,
    this.isPublic,
    this.expectedTransTime,
    this.agentName,
    this.agentPhone,
    this.houseArea,
    this.confirmFieldUser,
    this.confirmKeyUser,
    this.confirmDealUser,
    this.confirmExclusiveUser,
  });

  dynamic companyLh;
  List<HouseBasicInfo>? houseBasicInfo;
  List<HousePrivateInformation>? housePrivateInformation;
  dynamic userLh;
  dynamic userLh1;
  dynamic userLh2;
  dynamic userLh3;
  dynamic userLh4;
  dynamic userLh5;
  dynamic userInfoMain;
  List<HouseImage>? houseImages;
  List<HouseAroundInfo>? houseAroundInfo;
  int houseId;
  String companyId;
  int ownerId;
  dynamic tradeType;
  dynamic houseType;
  dynamic houseCommunity;
  dynamic houseAddress;
  dynamic tradeReason;
  dynamic houseFrom;
  dynamic housePrice;
  dynamic tradeLevel;
  dynamic inputUser;
  dynamic maintenanceUser;
  dynamic fieldUser;
  dynamic keyUser;
  dynamic dealUser;
  dynamic exclusiveUser;
  DateTime? addTime;
  dynamic houseIntro;
  dynamic isPublic;
  DateTime? expectedTransTime;
  dynamic agentName;
  dynamic agentPhone;
  dynamic houseArea;
  dynamic confirmFieldUser;
  dynamic confirmKeyUser;
  dynamic confirmDealUser;
  dynamic confirmExclusiveUser;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
  companyLh: json["Company_LH"] == null ? null : json["Company_LH"],
  houseBasicInfo: json["HouseBasicInfo"] == null ? null : List<HouseBasicInfo>.from(json["HouseBasicInfo"].map((x) => HouseBasicInfo.fromJson(x))),
  housePrivateInformation: json["HousePrivateInformation"] == null ? null : List<HousePrivateInformation>.from(json["HousePrivateInformation"].map((x) => HousePrivateInformation.fromJson(x))),
  userLh: json["User_LH"] == null ? null : json["User_LH"],
  userLh1: json["User_LH1"] == null ? null : json["User_LH1"],
  userLh2: json["User_LH2"] == null ? null : json["User_LH2"],
  userLh3: json["User_LH3"] == null ? null : json["User_LH3"],
  userLh4: json["User_LH4"] == null ? null : json["User_LH4"],
  userLh5: json["User_LH5"] == null ? null : json["User_LH5"],
  userInfoMain: json["UserInfoMain"] == null ? null : json["UserInfoMain"],
  houseImages: json["HouseImages"] == null ? null : List<HouseImage>.from(json["HouseImages"].map((x) => HouseImage.fromJson(x))),
  houseAroundInfo: json["HouseAroundInfo"] == null ? null : List<HouseAroundInfo>.from(json["HouseAroundInfo"].map((x) => HouseAroundInfo.fromJson(x))),
  houseId: json["HouseID"] == null ? null : json["HouseID"],
  companyId: json["CompanyID"] == null ? null : json["CompanyID"],
    ownerId: json["OwnerID"] == null ? null : json["OwnerID"],
    tradeType: json["TradeType"] == null ? null : json["TradeType"],
    houseType: json["HouseType"] == null ? null : json["HouseType"],
    houseCommunity: json["HouseCommunity"] == null ? null : json["HouseCommunity"],
    houseAddress: json["HouseAddress"] == null ? null : json["HouseAddress"],
    tradeReason: json["TradeReason"] == null ? null : json["TradeReason"],
    houseFrom: json["HouseFrom"] == null ? null : json["HouseFrom"],
    housePrice: json["HousePrice"] == null ? null : json["HousePrice"],
    tradeLevel: json["TradeLevel"] == null ? null : json["TradeLevel"],
    inputUser: json["InputUser"] == null ? null : json["InputUser"],
    maintenanceUser: json["MaintenanceUser"] == null ? null : json["MaintenanceUser"],
    fieldUser: json["FieldUser"] == null ? null : json["FieldUser"],
    keyUser: json["KeyUser"] == null ? null : json["KeyUser"],
    dealUser: json["DealUser"] == null ? null : json["DealUser"],
    exclusiveUser: json["ExclusiveUser"] == null ? null : json["ExclusiveUser"],
    addTime: json["AddTime"] == null ? null : DateTime.parse(json["AddTime"]),
    houseIntro: json["HouseIntro"] == null ? null : json["HouseIntro"],
    isPublic: json["IsPublic"] == null ? null : json["IsPublic"],
    expectedTransTime: json["ExpectedTransTime"] == null ? null : DateTime.parse(json["ExpectedTransTime"]),
    agentName: json["AgentName"] == null ? null : json["AgentName"],
    agentPhone: json["AgentPhone"] == null ? null : json["AgentPhone"],
    houseArea: json["HouseArea"] == null ? null : json["HouseArea"],
    confirmFieldUser: json["ConfirmFieldUser"] == null ? null : json["ConfirmFieldUser"],
    confirmKeyUser: json["ConfirmKeyUser"] == null ? null : json["ConfirmKeyUser"],
    confirmDealUser: json["ConfirmDealUser"] == null ? null : json["ConfirmDealUser"],
    confirmExclusiveUser: json["ConfirmExclusiveUser"] == null ? null : json["ConfirmExclusiveUser"],
  );

  Map<String, dynamic> toJson() => {
  "Company_LH": companyLh == null ? null : companyLh,
  "HouseBasicInfo": houseBasicInfo == null ? null : List<dynamic>.from(houseBasicInfo!.map((x) => x.toJson())),
  "HousePrivateInformation": housePrivateInformation == null ? null : List<dynamic>.from(housePrivateInformation!.map((x) => x.toJson())),
  "User_LH": userLh == null ? null : userLh,
  "User_LH1": userLh1 == null ? null : userLh1,
  "User_LH2": userLh2 == null ? null : userLh2,
  "User_LH3": userLh3 == null ? null : userLh3,
  "User_LH4": userLh4 == null ? null : userLh4,
  "User_LH5": userLh5 == null ? null : userLh5,
  "UserInfoMain": userInfoMain == null ? null : userInfoMain,
  "HouseImages": houseImages == null ? null : List<dynamic>.from(houseImages!.map((x) => x.toJson())),
  "HouseAroundInfo": houseAroundInfo == null ? null : List<dynamic>.from(houseAroundInfo!.map((x) => x.toJson())),
  "HouseID": houseId,
  "CompanyID": companyId,
  "OwnerID": ownerId,
  "TradeType": tradeType == null ? null : tradeType,
  "HouseType": houseType == null ? null : houseType,
  "HouseCommunity": houseCommunity == null ? null : houseCommunity,
  "HouseAddress": houseAddress == null ? null : houseAddress,
  "TradeReason": tradeReason == null ? null : tradeReason,
  "HouseFrom": houseFrom == null ? null : houseFrom,
  "HousePrice": housePrice == null ? null : housePrice,
  "TradeLevel": tradeLevel == null ? null : tradeLevel,
  "InputUser": inputUser == null ? null : inputUser,
  "MaintenanceUser": maintenanceUser == null ? null : maintenanceUser,
  "FieldUser": fieldUser == null ? null : fieldUser,
  "KeyUser": keyUser == null ? null : keyUser,
  "DealUser": dealUser == null ? null : dealUser,
  "ExclusiveUser": exclusiveUser == null ? null : exclusiveUser,
  "AddTime": addTime == null ? null : addTime!.toIso8601String(),
  "HouseIntro": houseIntro == null ? null : houseIntro,
  "IsPublic": isPublic == null ? null : isPublic,
  "ExpectedTransTime": expectedTransTime == null ? null : expectedTransTime!.toIso8601String(),
    "AgentName": agentName == null ? null : agentName,
    "AgentPhone": agentPhone == null ? null : agentPhone,
    "HouseArea": houseArea == null ? null : houseArea,
    "ConfirmFieldUser": confirmFieldUser == null ? null : confirmFieldUser,
    "ConfirmKeyUser": confirmKeyUser == null ? null : confirmKeyUser,
    "ConfirmDealUser": confirmDealUser == null ? null : confirmDealUser,
    "ConfirmExclusiveUser": confirmExclusiveUser == null ? null : confirmExclusiveUser,
  };
}

class HouseAroundInfo {
  HouseAroundInfo({
    required this.aroundInfoId,
    required this.houseId,
    required this.isInSchoolArea,
    this.school,
    this.traffic,
    this.entertainment,
    this.hospital,
    this.bank,
    this.park,
    this.otherLabel,
    this.otherIntro,
  });

  int aroundInfoId;
  int houseId;
  bool isInSchoolArea;
  dynamic school;
  dynamic traffic;
  dynamic entertainment;
  dynamic hospital;
  dynamic bank;
  dynamic park;
  dynamic otherLabel;
  dynamic otherIntro;

  factory HouseAroundInfo.fromJson(Map<String, dynamic> json) => HouseAroundInfo(
    aroundInfoId: json["AroundInfoID"] == null ? null : json["AroundInfoID"],
    houseId: json["HouseID"] == null ? null : json["HouseID"],
    isInSchoolArea: json["IsInSchoolArea"] == null ? null : json["IsInSchoolArea"],
    school: json["School"] == null ? null : json["School"],
    traffic: json["Traffic"] == null ? null : json["Traffic"],
    entertainment: json["Entertainment"] == null ? null : json["Entertainment"],
    hospital: json["Hospital"] == null ? null : json["Hospital"],
    bank: json["Bank"] == null ? null : json["Bank"],
    park: json["Park"] == null ? null : json["Park"],
    otherLabel: json["OtherLabel"] == null ? null : json["OtherLabel"],
    otherIntro: json["OtherIntro"] == null ? null : json["OtherIntro"],
  );

  Map<String, dynamic> toJson() => {
  "AroundInfoID": aroundInfoId,
  "HouseID": houseId,
  "IsInSchoolArea": isInSchoolArea,
  "School": school == null ? null : school,
  "Traffic": traffic == null ? null : traffic,
  "Entertainment": entertainment == null ? null : entertainment,
    "Hospital": hospital == null ? null : hospital,
    "Bank": bank == null ? null : bank,
    "Park": park == null ? null : park,
    "OtherLabel": otherLabel == null ? null : otherLabel,
    "OtherIntro": otherIntro == null ? null : otherIntro,
  };
}

class HouseBasicInfo {
  HouseBasicInfo({
    required this.basicInfoId,
    required this.houseId,
    this.area,
    this.structure,
    this.orientation,
    this.floor,
    this.totalFloor,
    this.decoration,
    this.houseAge,
    this.managementCompany,
    this.managementPrice,
    this.haveElevator,
    this.tax,
    this.houseImages,
    this.housePlan,
    this.uploadTime,
  });

  int basicInfoId;
  int houseId;
  dynamic area;
  dynamic structure;
  dynamic orientation;
  dynamic floor;
  dynamic totalFloor;
  dynamic decoration;
  dynamic houseAge;
  dynamic managementCompany;
  dynamic managementPrice;
  dynamic haveElevator;
  dynamic tax;
  dynamic houseImages;
  dynamic housePlan;
  DateTime? uploadTime;

  factory HouseBasicInfo.fromJson(Map<String, dynamic> json) => HouseBasicInfo(
  basicInfoId: json["BasicInfoID"] == null ? null : json["BasicInfoID"],
  houseId: json["HouseID"] == null ? null : json["HouseID"],
  area: json["Area"] == null ? null : json["Area"],
  structure: json["Structure"] == null ? null : json["Structure"],
  orientation: json["Orientation"] == null ? null : json["Orientation"],
  floor: json["Floor"] == null ? null : json["Floor"],
  totalFloor: json["TotalFloor"] == null ? null : json["TotalFloor"],
  decoration: json["Decoration"] == null ? null : json["Decoration"],
  houseAge: json["HouseAge"] == null ? null : json["HouseAge"],
  managementCompany: json["ManagementCompany"] == null ? null : json["ManagementCompany"],
  managementPrice: json["ManagementPrice"] == null ? null : json["ManagementPrice"].toDouble(),
  haveElevator: json["HaveElevator"] == null ? null : json["HaveElevator"],
  tax: json["Tax"] == null ? null : json["Tax"],
    houseImages: json["HouseImages"] == null ? null : json["HouseImages"],
    housePlan: json["HousePlan"] == null ? null : json["HousePlan"],
    uploadTime: json["UploadTime"] == null ? null : DateTime.parse(json["UploadTime"]),
  );

  Map<String, dynamic> toJson() => {
    "BasicInfoID": basicInfoId,
    "HouseID": houseId,
    "Area": area == null ? null : area,
    "Structure": structure == null ? null : structure,
    "Orientation": orientation == null ? null : orientation,
    "Floor": floor == null ? null : floor,
    "TotalFloor": totalFloor == null ? null : totalFloor,
    "Decoration": decoration == null ? null : decoration,
    "HouseAge": houseAge == null ? null : houseAge,
    "ManagementCompany": managementCompany == null ? null : managementCompany,
    "ManagementPrice": managementPrice == null ? null : managementPrice,
    "HaveElevator": haveElevator == null ? null : haveElevator,
    "Tax": tax == null ? null : tax,
    "HouseImages": houseImages == null ? null : houseImages,
    "HousePlan": housePlan == null ? null : housePlan,
    "UploadTime": uploadTime == null ? null : uploadTime!.toIso8601String(),
  };
}
class HouseImage {
  HouseImage({
    required this.id,
    required this.houseId,
    this.keyImage,
    this.keyStartDate,
    this.keyEndDate,
    this.dealImage,
    this.dealDate,
  });

  int id;
  int houseId;
  dynamic keyImage;
  DateTime? keyStartDate;
  DateTime? keyEndDate;
  dynamic dealImage;
  DateTime? dealDate;

  factory HouseImage.fromJson(Map<String, dynamic> json) => HouseImage(
    id: json["ID"] == null ? null : json["ID"],
    houseId: json["HouseID"] == null ? null : json["HouseID"],
    keyImage: json["KeyImage"] == null ? null : json["KeyImage"],
    keyStartDate: json["KeyStartDate"] == null ? null : DateTime.parse(json["KeyStartDate"]),
    keyEndDate: json["KeyEndDate"] == null ? null : DateTime.parse(json["KeyEndDate"]),
    dealImage: json["DealImage"] == null ? null : json["DealImage"],
    dealDate: json["DealDate"] == null ? null : DateTime.parse(json["DealDate"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "HouseID": houseId,
    "KeyImage": keyImage == null ? null : keyImage,
    "KeyStartDate": keyStartDate == null ? null : keyStartDate!.toIso8601String(),
    "KeyEndDate": keyEndDate == null ? null : keyEndDate!.toIso8601String(),
    "DealImage": dealImage == null ? null : dealImage,
    "DealDate": dealDate == null ? null : dealDate!.toIso8601String(),
  };
}
class HousePrivateInformation {
  HousePrivateInformation({
    required this.privateInfoId,
    required this.houseId,
    this.ownerIdCard,
    this.houseOwnerShipImg,
    this.needVerify,
    this.verifyResult,
    this.consignmentAgreement,
    this.consignmentAgreementStart,
    this.consignmentAgreementExpr,
    this.exclusiveConsignmentAgreement,
    this.exclusiveConsignmentAgreementStart,
    this.exclusiveConsignmentAgreementExpr,
  });

  int privateInfoId;
  int houseId;
  dynamic ownerIdCard;
  dynamic houseOwnerShipImg;
  dynamic needVerify;
  dynamic verifyResult;
  dynamic consignmentAgreement;
  DateTime? consignmentAgreementStart;
  DateTime? consignmentAgreementExpr;
  dynamic exclusiveConsignmentAgreement;
  DateTime? exclusiveConsignmentAgreementStart;
  DateTime? exclusiveConsignmentAgreementExpr;

  factory HousePrivateInformation.fromJson(Map<String, dynamic> json) => HousePrivateInformation(
  privateInfoId: json["PrivateInfoID"] == null ? null : json["PrivateInfoID"],
  houseId: json["HouseID"] == null ? null : json["HouseID"],
  ownerIdCard: json["OwnerIDCard"] == null ? null : json["OwnerIDCard"],
    houseOwnerShipImg: json["HouseOwnerShipImg"] == null ? null : json["HouseOwnerShipImg"],
    needVerify: json["NeedVerify"] == null ? null : json["NeedVerify"],
    verifyResult: json["VerifyResult"] == null ? null : json["VerifyResult"],
    consignmentAgreement: json["ConsignmentAgreement"] == null ? null : json["ConsignmentAgreement"],
    consignmentAgreementStart: json["ConsignmentAgreementStart"] == null ? null : DateTime.parse(json["ConsignmentAgreementStart"]),
    consignmentAgreementExpr: json["ConsignmentAgreementExpr"] == null ? null : DateTime.parse(json["ConsignmentAgreementExpr"]),
    exclusiveConsignmentAgreement: json["ExclusiveConsignmentAgreement"] == null ? null : json["ExclusiveConsignmentAgreement"],
    exclusiveConsignmentAgreementStart: json["ExclusiveConsignmentAgreementStart"] == null ? null : DateTime.parse(json["ExclusiveConsignmentAgreementStart"]),
    exclusiveConsignmentAgreementExpr: json["ExclusiveConsignmentAgreementExpr"] == null ? null : DateTime.parse(json["ExclusiveConsignmentAgreementExpr"]),
  );

  Map<String, dynamic> toJson() => {
    "PrivateInfoID": privateInfoId,
    "HouseID": houseId,
    "OwnerIDCard": ownerIdCard == null ? null : ownerIdCard,
    "HouseOwnerShipImg": houseOwnerShipImg == null ? null : houseOwnerShipImg,
    "NeedVerify": needVerify == null ? null : needVerify,
    "VerifyResult": verifyResult == null ? null : verifyResult,
    "ConsignmentAgreement": consignmentAgreement == null ? null : consignmentAgreement,
    "ConsignmentAgreementStart": consignmentAgreementStart == null ? null : consignmentAgreementStart!.toIso8601String(),
    "ConsignmentAgreementExpr": consignmentAgreementExpr == null ? null : consignmentAgreementExpr!.toIso8601String(),
    "ExclusiveConsignmentAgreement": exclusiveConsignmentAgreement == null ? null : exclusiveConsignmentAgreement,
    "ExclusiveConsignmentAgreementStart": exclusiveConsignmentAgreementStart == null ? null : exclusiveConsignmentAgreementStart!.toIso8601String(),
    "ExclusiveConsignmentAgreementExpr": exclusiveConsignmentAgreementExpr == null ? null : exclusiveConsignmentAgreementExpr!.toIso8601String(),
  };
}
