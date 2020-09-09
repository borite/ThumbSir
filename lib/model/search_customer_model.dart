// To parse this JSON data, do
//
//     final searchCustomer = searchCustomerFromJson(jsonString);

import 'dart:convert';

SearchCustomer searchCustomerFromJson(String str) => SearchCustomer.fromJson(json.decode(str));

String searchCustomerToJson(SearchCustomer data) => json.encode(data.toJson());

class SearchCustomer {
  SearchCustomer({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum> data;

  factory SearchCustomer.fromJson(Map<String, dynamic> json) => SearchCustomer(
    code: json["Code"] == null ? null : json["Code"],
    message: json["Message"] == null ? null : json["Message"],
    data: json["Data"] == null ? null : List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Code": code == null ? null : code,
    "Message": message == null ? null : message,
    "Data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.familyMember,
    this.userCustomerDemand,
    this.userOwnerDemand,
    this.dealList,
    this.customerRetention,
    this.mid,
    this.companyId,
    this.userId,
    this.userType,
    this.userName,
    this.sex,
    this.phone,
    this.birthday,
    this.starslevel,
    this.occupation,
    this.income,
    this.hobby,
    this.remark,
    this.address,
  });

  List<dynamic> familyMember;
  List<dynamic> userCustomerDemand;
  List<dynamic> userOwnerDemand;
  List<dynamic> dealList;
  List<dynamic> customerRetention;
  int mid;
  String companyId;
  String userId;
  int userType;
  String userName;
  int sex;
  String phone;
  DateTime birthday;
  int starslevel;
  dynamic occupation;
  String income;
  String hobby;
  String remark;
  String address;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    familyMember: json["FamilyMember"] == null ? null : List<dynamic>.from(json["FamilyMember"].map((x) => x)),
    userCustomerDemand: json["UserCustomerDemand"] == null ? null : List<dynamic>.from(json["UserCustomerDemand"].map((x) => x)),
    userOwnerDemand: json["UserOwnerDemand"] == null ? null : List<dynamic>.from(json["UserOwnerDemand"].map((x) => x)),
    dealList: json["DealList"] == null ? null : List<dynamic>.from(json["DealList"].map((x) => x)),
    customerRetention: json["CustomerRetention"] == null ? null : List<dynamic>.from(json["CustomerRetention"].map((x) => x)),
    mid: json["MID"] == null ? null : json["MID"],
    companyId: json["CompanyID"] == null ? null : json["CompanyID"],
    userId: json["UserID"] == null ? null : json["UserID"],
    userType: json["UserType"] == null ? null : json["UserType"],
    userName: json["UserName"] == null ? null : json["UserName"],
    sex: json["Sex"] == null ? null : json["Sex"],
    phone: json["Phone"] == null ? null : json["Phone"],
    birthday: json["Birthday"] == null ? null : DateTime.parse(json["Birthday"]),
    starslevel: json["Starslevel"] == null ? null : json["Starslevel"],
    occupation: json["occupation"],
    income: json["Income"] == null ? null : json["Income"],
    hobby: json["Hobby"] == null ? null : json["Hobby"],
    remark: json["Remark"] == null ? null : json["Remark"],
    address: json["Address"] == null ? null : json["Address"],
  );

  Map<String, dynamic> toJson() => {
  "FamilyMember": familyMember == null ? null : List<dynamic>.from(familyMember.map((x) => x)),
  "UserCustomerDemand": userCustomerDemand == null ? null : List<dynamic>.from(userCustomerDemand.map((x) => x)),
  "UserOwnerDemand": userOwnerDemand == null ? null : List<dynamic>.from(userOwnerDemand.map((x) => x)),
    "DealList": dealList == null ? null : List<dynamic>.from(dealList.map((x) => x)),
    "CustomerRetention": customerRetention == null ? null : List<dynamic>.from(customerRetention.map((x) => x)),
    "MID": mid == null ? null : mid,
    "CompanyID": companyId == null ? null : companyId,
    "UserID": userId == null ? null : userId,
    "UserType": userType == null ? null : userType,
    "UserName": userName == null ? null : userName,
    "Sex": sex == null ? null : sex,
    "Phone": phone == null ? null : phone,
    "Birthday": birthday == null ? null : birthday.toIso8601String(),
    "Starslevel": starslevel == null ? null : starslevel,
    "occupation": occupation,
    "Income": income == null ? null : income,
    "Hobby": hobby == null ? null : hobby,
    "Remark": remark == null ? null : remark,
    "Address": address == null ? null : address,
  };
}