// To parse this JSON data, do
//
//     final getCombinCustomerInfo = getCombinCustomerInfoFromJson(jsonString);

import 'dart:convert';

GetCombinCustomerInfo getCombinCustomerInfoFromJson(String str) => GetCombinCustomerInfo.fromJson(json.decode(str));

String getCombinCustomerInfoToJson(GetCombinCustomerInfo data) => json.encode(data.toJson());

class GetCombinCustomerInfo {
  GetCombinCustomerInfo({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory GetCombinCustomerInfo.fromJson(Map<String, dynamic> json) => GetCombinCustomerInfo(
    code: json["Code"],
    message: json["Message"],
    data: Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": data!.toJson(),
  };
}

class Data {
  Data({
    this.yezhuList,
    this.kehuResult,
  });

  List<YezhuList>? yezhuList;
  List<KehuResult>? kehuResult;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    yezhuList: List<YezhuList>.from(json["yezhuList"].map((x) => YezhuList.fromJson(x))),
    kehuResult: List<KehuResult>.from(json["kehuResult"].map((x) => KehuResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "yezhuList": List<dynamic>.from(yezhuList!.map((x) => x.toJson())),
    "kehuResult": List<dynamic>.from(kehuResult!.map((x) => x.toJson())),
  };
}

class KehuResult {
  KehuResult({
    this.selectedMissionId,
    this.selectedMissionName,
    this.mlist,
  });

  dynamic selectedMissionId;
  dynamic selectedMissionName;
  List<Mlist>? mlist;

  factory KehuResult.fromJson(Map<String, dynamic> json) => KehuResult(
    selectedMissionId: json["SelectedMissionID"],
    selectedMissionName: json["SelectedMissionName"],
    mlist: List<Mlist>.from(json["mlist"].map((x) => Mlist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "SelectedMissionID": selectedMissionId,
    "SelectedMissionName": selectedMissionName,
    "mlist": List<dynamic>.from(mlist!.map((x) => x.toJson())),
  };
}

class Mlist {
  Mlist({
    this.caid,
    this.houseId,
    this.customerId,
    this.description,
    this.selectedMissionId,
    this.phone,
    this.userName,
    this.houseNum,
    this.houseCommunity,
    this.houseAddress,
    this.planningStartTime,
    this.planningEndTime,
    this.id,
    this.selectedMissionName,
    this.remark,
    this.userType,
  });

  dynamic caid;
  dynamic houseId;
  dynamic customerId;
  dynamic description;
  dynamic selectedMissionId;
  dynamic phone;
  dynamic userName;
  dynamic houseNum;
  dynamic houseCommunity;
  dynamic houseAddress;
  DateTime? planningStartTime;
  DateTime? planningEndTime;
  dynamic id;
  dynamic selectedMissionName;
  dynamic remark;
  dynamic userType;

  factory Mlist.fromJson(Map<String, dynamic> json) => Mlist(
    caid: json["CAID"],
    houseId: json["HouseID"],
    customerId: json["CustomerID"],
    description: json["Description"],
    selectedMissionId: json["SelectedMissionID"],
    phone: json["Phone"],
    userName: json["UserName"],
    houseNum: json["HouseNum"],
    houseCommunity: json["HouseCommunity"],
    houseAddress: json["HouseAddress"],
    planningStartTime: DateTime.parse(json["PlanningStartTime"]),
    planningEndTime: DateTime.parse(json["PlanningEndTime"]),
    id: json["ID"],
    selectedMissionName: json["SelectedMissionName"],
    remark: json["Remark"] == null ? null : json["Remark"],
    userType: json["UserType"],
  );

  Map<String, dynamic> toJson() => {
  "CAID": caid,
  "HouseID": houseId,
  "CustomerID": customerId,
  "Description": description,
  "SelectedMissionID": selectedMissionId,
  "Phone": phone,
    "UserName": userName,
    "HouseNum": houseNum,
    "HouseCommunity": houseCommunity,
    "HouseAddress": houseAddress,
    "PlanningStartTime": planningStartTime!.toIso8601String(),
    "PlanningEndTime": planningEndTime!.toIso8601String(),
    "ID": id,
    "SelectedMissionName": selectedMissionName,
    "Remark": remark == null ? null : remark,
    "UserType": userType,
  };
}

class YezhuList {
  YezhuList({
    this.houseNum,
    this.houseCommunity,
    this.houseAddress,
    this.haid,
    this.houseId,
    this.selectedMissionId,
    this.missionName,
    this.missionDescription,
    this.addTime,
    this.addUserId,
    this.customerId,
    this.phone,
    this.userName,
    this.planningStartTime,
    this.planningEndTime,
    this.houseIntro,
    this.defaultTaskId,
  });

  dynamic houseNum;
  dynamic houseCommunity;
  dynamic houseAddress;
  dynamic haid;
  dynamic houseId;
  dynamic selectedMissionId;
  dynamic missionName;
  dynamic missionDescription;
  DateTime? addTime;
  dynamic addUserId;
  dynamic customerId;
  dynamic phone;
  dynamic userName;
  dynamic planningStartTime;
  dynamic planningEndTime;
  dynamic houseIntro;
  dynamic defaultTaskId;

  factory YezhuList.fromJson(Map<String, dynamic> json) => YezhuList(
  houseNum: json["HouseNum"],
  houseCommunity: json["HouseCommunity"],
  houseAddress: json["HouseAddress"],
  haid: json["HAID"],
  houseId: json["HouseID"],
  selectedMissionId: json["SelectedMissionID"],
  missionName: json["MissionName"],
  missionDescription: json["MissionDescription"],
  addTime: DateTime.parse(json["AddTime"]),
  addUserId: json["AddUserID"],
  customerId: json["CustomerID"],
  phone: json["Phone"],
  userName: json["UserName"],
  planningStartTime: json["PlanningStartTime"],
  planningEndTime: json["PlanningEndTime"],
    houseIntro: json["HouseIntro"],
    defaultTaskId: json["DefaultTaskID"],
  );

  Map<String, dynamic> toJson() => {
    "HouseNum": houseNum,
    "HouseCommunity": houseCommunity,
    "HouseAddress": houseAddress,
    "HAID": haid,
    "HouseID": houseId,
    "SelectedMissionID": selectedMissionId,
    "MissionName": missionName,
    "MissionDescription": missionDescription,
    "AddTime": addTime!.toIso8601String(),
    "AddUserID": addUserId,
    "CustomerID": customerId,
    "Phone": phone,
    "UserName": userName,
    "PlanningStartTime": planningStartTime,
    "PlanningEndTime": planningEndTime,
    "HouseIntro": houseIntro,
    "DefaultTaskID": defaultTaskId,
  };
}