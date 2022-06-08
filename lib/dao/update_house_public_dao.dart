import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/add_house_step1_model.dart';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String api_perfix=CommonVars.testApiPrefix;

class UpdateHousePublicDao{
    static Future<CommonResult> updateHousePublic(
        String HouseID,
        bool IsPublic,
    ) async {
      //组织要发送给APi的键值对
      var _body={
        "HouseID":HouseID,
        "IsPublic":IsPublic,
      };
       final String apiUrl=api_perfix+"/api/houseresource/UpdateHousePublic";
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
