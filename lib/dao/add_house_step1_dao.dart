import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/add_house_step1_model.dart';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String api_perfix=CommonVars.testApiPrefix;

class AddHouseStep1Dao{
    static Future<AddHouseStep1> addHouseStep1(
        String companyID,
        String OwnerName,
        String OwnerPhone,
        String UserID,
        String ExpectedTransTime,
        String TradeType,
        String HouseType,
        String HouseArea,
        String HouseCommunity,
        String HouseAddress,
        String HouseFrom,
        int HousePrice,
        String TradeLevel,
        String TradeReason,
        String AgentName,
        String AgentPhone,
        String HouseIntro,
    ) async {
      //组织要发送给APi的键值对
      var _body={
        "CompanyID":companyID,
        "OwnerName":OwnerName,
        "OwnerPhone": OwnerPhone,
        "UserID": UserID,
        "ExpectedTransTime": ExpectedTransTime,
        "TradeType": TradeType,
        "HouseType": HouseType,
        "HouseArea": HouseArea,
        "HouseCommunity": HouseCommunity,
        "HouseAddress": HouseAddress,
        "HouseFrom": HouseFrom,
        "HousePrice": HousePrice,
        "TradeLevel": TradeLevel,
        "TradeReason":TradeReason,
        "AgentName":AgentName,
        "AgentPhone":AgentPhone,
        "HouseIntro":HouseIntro
      };
       final String apiUrl=api_perfix+"/api/houseresource/AddHouseStep1";
       final response= await http.post(apiUrl,
           headers: {'Content-type': 'application/json'},  //告诉服务器，发送的数据类型为Json类型
           body: json.encode(_body)  //将body的键值对用Json形式编码发送
       );
       if(response.statusCode==200){
         return addHouseStep1FromJson(response.body);
       }else{
//         return null;
         throw Exception(response.body);
       }
    }
}
