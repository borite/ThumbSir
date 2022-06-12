import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String apiPerFix=Url.testApiPrefix;

class ModiHousePriceDao{
    static Future<CommonResult> modiHousePrice(
        String HouseID,
        String price,
        String userID,
        String modiReason,
    ) async {
      //组织要发送给APi的键值对
      var _body={
        "HouseID":HouseID,
        "Price":price,
        "UserID": userID,
        "ModiReason": modiReason,
      };
      var client = http.Client();
      final response= await client.post(
          Uri.http(apiPerFix,'/api/houseresource/ModiHousePrice'),
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
