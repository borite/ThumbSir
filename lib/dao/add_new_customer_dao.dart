import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String api_perfix=CommonVars.testApiPrefix;

class AddNewCustomerDao{
    static Future<CommonResult> addNewCustomer(
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
        String customerFrom,
        List familyMembers,
        List dealInfoWithCreateCustomer,
        List customerNeedsWithCreate,
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
      var _body={
        "CompanyID":companyID,
        "UserID":userID,
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
        "DealInfoWithCreateCustomer":dealInfoWithCreateCustomer,
        "CustomerNeedsWithCreate":customerNeedsWithCreate,
        "CustomerFrom":customerFrom
      };
       final String apiUrl=api_perfix+"api/customerfrom/AddNewCustomer";
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

BuySellNeedInfo buySellNeedInfoFromJson(String str) => BuySellNeedInfo.fromJson(json.decode(str));

String buySellNeedInfoToJson(BuySellNeedInfo data) => json.encode(data.toJson());

class BuySellNeedInfo {
  BuySellNeedInfo({
    this.buySellNeedReason,
  });

  String buySellNeedReason;

  factory BuySellNeedInfo.fromJson(Map<String, dynamic> json) => BuySellNeedInfo(
    buySellNeedReason: json["Needs"] == null ? null : json["Needs"],
  );

  Map<String, dynamic> toJson() => {
    "Needs": buySellNeedReason == null ? null : buySellNeedReason,
  };
}

