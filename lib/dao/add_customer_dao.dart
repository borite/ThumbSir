import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String api_perfix=CommonVars.apiPrefix;

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

//      //创建一个List，里面存的是FamilyMember类型的实例对象
//      List<FamilyMember> m=new List();
//
//      List aaa=new List();
//      //遍历传入的List familyMembers
//      familyMembers.forEach((element) {
//        //把每一个json字符串转换为FamilyMember的实例对象
//        var i=familyMemberToJson(element);
//        //放在m这个List里
//       aaa.add(i);
//      });

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
      print(json.encode(_body));
       final String apiUrl=api_perfix+"api/customer/AddCustomer";
       final response= await http.post(apiUrl,
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
    this.role,
    this.hobby,
  });

  String role;
  String hobby;

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
    role: json["Role"] == null ? null : json["Role"],
    hobby: json["Hobby"] == null ? null : json["Hobby"],
  );

  Map<String, dynamic> toJson() => {
    "Role": role == null ? null : role,
    "Hobby": hobby == null ? null : hobby,
  };
}

DealInfo dealInfoFromJson(String str) => DealInfo.fromJson(json.decode(str));

String dealInfoToJson(DealInfo data) => json.encode(data.toJson());

class DealInfo {
  DealInfo({
    this.dealReason,
    this.dealTime,
  });

  String dealReason;
  DateTime dealTime;

  factory DealInfo.fromJson(Map<String, dynamic> json) => DealInfo(
    dealReason: json["DealReason"] == null ? null : json["DealReason"],
    dealTime: json["DealTime"] == null ? null : DateTime.parse(json["DealTime"]),
  );

  Map<String, dynamic> toJson() => {
    "DealReason": dealReason == null ? null : dealReason,
    "DealTime": dealTime == null ? null : dealTime.toIso8601String(),
  };
}

