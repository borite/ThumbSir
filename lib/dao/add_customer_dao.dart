import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String apiPerFix=Url.apiPrefix;

class AddCustomerDao{
    static Future<CommonResult> addCustomer(
        String companyID,
        String userID,
        String userType,
        String userName,
        String sex,
        String phone,
        String birthday,
        String starsLevel,
        String occupation,
        String income,
        String hobby,
        String remark,
        String address,
        List familyMembers,
        List dealInfoWithCreateCustomer
    ) async {
      //组织要发送给APi的键值对
      var _body={"CompanyID":companyID,
        "userID":userID,
        "UserType": userType,
        "UserName": userName,
        "Sex": sex,
        "Phone": phone,
        "Birthday": birthday,
        "Starslevel": starsLevel,
        "occupation": occupation,
        "Income": income,
        "Hobby": hobby,
        "Remark": remark,
        "Address": address,
        "FamilyMembers":familyMembers,
        "DealInfoWithCreateCustomer":dealInfoWithCreateCustomer
      };
      var client = http.Client();
      final response= await client.post(
          Uri.http(apiPerFix,'/api/customer/AddCustomer'),
          headers: {'Content-type': 'application/json'},  //告诉服务器，发送的数据类型为Json类型
          body: json.encode(_body)  //将body的键值对用Json形式编码发送
       );
       if(response.statusCode==200){
         return commonResultFromJson(response.body);
       }else{
//         return null;
         throw Exception(response.body);
       }
    }
}

FamilyMember familyMemberFromJson(String str) => FamilyMember.fromJson(json.decode(str));

String familyMemberToJson(FamilyMember data) => json.encode(data.toJson());

class FamilyMember {
  FamilyMember({
    this.memberRole,
    this.memberHobby,
  });

  String? memberRole;
  String? memberHobby;

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
    memberRole: json["MemberRole"] == null ? null : json["MemberRole"],
    memberHobby: json["MemberHobby"] == null ? null : json["MemberHobby"],
  );

  Map<String, dynamic> toJson() => {
    "MemberRole": memberRole == null ? null : memberRole,
    "MemberHobby": memberHobby == null ? null : memberHobby,
  };
}

DealInfo dealInfoFromJson(String str) => DealInfo.fromJson(json.decode(str));

String dealInfoToJson(DealInfo data) => json.encode(data.toJson());

class DealInfo {
  DealInfo({
    this.dealReason,
    this.dealTime,
  });

  String? dealReason;
  DateTime? dealTime;

  factory DealInfo.fromJson(Map<String, dynamic> json) => DealInfo(
    dealReason: json["DealReason"] == null ? null : json["DealReason"],
    dealTime: json["DealTime"] == null ? null : DateTime.parse(json["DealTime"]),
  );

  Map<String, dynamic> toJson() => {
    "DealReason": dealReason == null ? null : dealReason,
    "DealTime": dealTime == null ? null : dealTime!.toIso8601String(),
  };
}

class NeedInfo {
  NeedInfo({
    this.needReason,
  });

  String? needReason;

  factory NeedInfo.fromJson(Map<String, dynamic> json) => NeedInfo(
    needReason: json["NeedReason"] == null ? null : json["NeedReason"],
  );

  Map<String, dynamic> toJson() => {
    "NeedReason": needReason == null ? null : needReason,
  };
}

