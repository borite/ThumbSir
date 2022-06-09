// To parse this JSON data, do
//
//     final getLeaderAndTeamMember = getLeaderAndTeamMemberFromJson(jsonString);

import 'dart:convert';

GetLeaderAndTeamMember getLeaderAndTeamMemberFromJson(String str) => GetLeaderAndTeamMember.fromJson(json.decode(str));

String getLeaderAndTeamMemberToJson(GetLeaderAndTeamMember data) => json.encode(data.toJson());

class GetLeaderAndTeamMember {
  GetLeaderAndTeamMember({
    required this.code,
    required this.message,
    this.data,
  });

  int code;
  String message;
  Data? data;

  factory GetLeaderAndTeamMember.fromJson(Map<String, dynamic> json) => GetLeaderAndTeamMember(
    code: json["Code"],
    message: json["Message"],
    data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.leader,
    this.teamMember,
  });

  Leader? leader;
  List<Leader>? teamMember;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    leader: json["leader"] == null ? null : Leader.fromJson(json["leader"]),
    teamMember: json["teamMember"] == null ? null : List<Leader>.from(json["teamMember"].map((x) => Leader.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "leader": leader == null ? null : leader!.toJson(),
    "teamMember": teamMember == null ? null : List<dynamic>.from(teamMember!.map((x) => x.toJson())),
  };
}

class Leader {
  Leader({
    required this.userPid,
    required this.userName,
    this.headImg,
    required this.phone,
    required this.section,
    required this.userType,
    this.email,
    required this.isVip,
    required this.userLevel,
    this.vipEndTime,
  });

  String userPid;
  String userName;
  dynamic headImg;
  String phone;
  String section;
  int userType;
  dynamic email;
  bool isVip;
  String userLevel;
  dynamic vipEndTime;

  factory Leader.fromJson(Map<String, dynamic> json) => Leader(
    userPid: json["UserPID"],
    userName: json["UserName"],
    headImg: json["HeadImg"],
    phone: json["Phone"],
    section: json["Section"],
    userType: json["UserType"],
    email: json["Email"],
    isVip: json["IsVIP"],
    userLevel: json["UserLevel"],
    vipEndTime: json["VipEndTime"],
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid,
    "UserName": userName,
    "HeadImg": headImg,
    "Phone": phone,
    "Section": section,
    "UserType": userType,
    "Email": email,
    "IsVIP": isVip,
    "UserLevel": userLevel,
    "VipEndTime": vipEndTime,
  };
}