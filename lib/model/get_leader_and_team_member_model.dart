// To parse this JSON data, do
//
//     final getLeaderAndTeamMember = getLeaderAndTeamMemberFromJson(jsonString);

import 'dart:convert';

GetLeaderAndTeamMember getLeaderAndTeamMemberFromJson(String str) => GetLeaderAndTeamMember.fromJson(json.decode(str));

String getLeaderAndTeamMemberToJson(GetLeaderAndTeamMember data) => json.encode(data.toJson());

class GetLeaderAndTeamMember {
  GetLeaderAndTeamMember({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  Data data;

  factory GetLeaderAndTeamMember.fromJson(Map<String, dynamic> json) => GetLeaderAndTeamMember(
    code: json["Code"] == null ? null : json["Code"],
    message: json["Message"] == null ? null : json["Message"],
    data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Code": code == null ? null : code,
    "Message": message == null ? null : message,
    "Data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.leader,
    this.teamMember,
  });

  Leader leader;
  List<Leader> teamMember;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    leader: json["leader"] == null ? null : Leader.fromJson(json["leader"]),
    teamMember: json["teamMember"] == null ? null : List<Leader>.from(json["teamMember"].map((x) => Leader.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "leader": leader == null ? null : leader.toJson(),
    "teamMember": teamMember == null ? null : List<dynamic>.from(teamMember.map((x) => x.toJson())),
  };
}

class Leader {
  Leader({
    this.userPid,
    this.userName,
    this.headImg,
    this.phone,
    this.section,
    this.userType,
    this.email,
    this.isVip,
    this.vipEndTime,
  });

  String userPid;
  String userName;
  dynamic headImg;
  String phone;
  String section;
  int userType;
  dynamic email;
  dynamic isVip;
  dynamic vipEndTime;

  factory Leader.fromJson(Map<String, dynamic> json) => Leader(
    userPid: json["UserPID"] == null ? null : json["UserPID"],
    userName: json["UserName"] == null ? null : json["UserName"],
    headImg: json["HeadImg"],
    phone: json["Phone"] == null ? null : json["Phone"],
    section: json["Section"] == null ? null : json["Section"],
    userType: json["UserType"] == null ? null : json["UserType"],
    email: json["Email"],
    isVip: json["IsVIP"],
    vipEndTime: json["VipEndTime"],
  );

  Map<String, dynamic> toJson() => {
    "UserPID": userPid == null ? null : userPid,
    "UserName": userName == null ? null : userName,
    "HeadImg": headImg,
    "Phone": phone == null ? null : phone,
    "Section": section == null ? null : section,
    "UserType": userType == null ? null : userType,
    "Email": email,
    "IsVIP": isVip,
    "VipEndTime": vipEndTime,
  };
}