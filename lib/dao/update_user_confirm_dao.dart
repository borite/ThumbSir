import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String apiPerFix=Url.testApiPrefix;

class UpdateUserConfirmDao{
    static Future<CommonResult> updateUserConfirm(
        int RoleCode,
        String HouseID,
        bool IsOK,
    ) async {
      //组织要发送给APi的键值对
      var _body={
        "RoleCode":RoleCode,
        "HouseID":HouseID,
        "IsOK":IsOK,
      };
      var client = http.Client();
      final response= await client.post(
          Uri.http(apiPerFix,'/api/houseresource/UpdateFieldUser'),
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
