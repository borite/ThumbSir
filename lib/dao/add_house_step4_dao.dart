import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/add_house_step1_model.dart';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String api_perfix=CommonVars.testApiPrefix;

class AddHouseStep4Dao{
    static Future<CommonResult> addHouseStep4(
        String HouseID,
        String OwnerIDCard,
        String HouseOwnerShipImg,
        String ConsignmentAgreement,
        String ConsignmentAgreementStart,
        String ConsignmentAgreementExpr,
        String ExclusiveConsignmentAgreement,
        String ExclusiveConsignmentAgreementStart,
        String ExclusiveConsignmentAgreementExpr,
    ) async {
      //组织要发送给APi的键值对
      var _body={
        "HouseID":HouseID,
        "OwnerIDCard":OwnerIDCard,
        "HouseOwnerShipImg": HouseOwnerShipImg,
        "ConsignmentAgreement": ConsignmentAgreement,
        "ConsignmentAgreementStart": ConsignmentAgreementStart,
        "ConsignmentAgreementExpr": ConsignmentAgreementExpr,
        "ExclusiveConsignmentAgreement": ExclusiveConsignmentAgreement,
        "ExclusiveConsignmentAgreementStart": ExclusiveConsignmentAgreementStart,
        "ExclusiveConsignmentAgreementExpr": ExclusiveConsignmentAgreementExpr,
      };
       final String apiUrl=api_perfix+"/api/houseresource/AddHouseStep4";
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
