import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import '../utils/common_vars.dart';

const String api_perfix=Url.testApiPrefix;

class AddHouseStep2Dao{
    static Future<CommonResult> addHouseStep2(
        String HouseID,
        String Area,
        String Structure,
        String Orientation,
        String Floor,
        String TotalFloor,
        String Decoration,
        String HouseAge,
        String ManagementCompany,
        String ManagementPrice,
        String HaveElevator,
        String Tax,
    ) async {
      //组织要发送给APi的键值对
      var _body={
        "HouseID":HouseID,
        "Area":Area,
        "Structure": Structure,
        "Orientation": Orientation,
        "Floor": Floor,
        "TotalFloor": TotalFloor,
        "Decoration": Decoration,
        "HouseAge": HouseAge,
        "ManagementCompany": ManagementCompany,
        "ManagementPrice": ManagementPrice,
        "HaveElevator": HaveElevator,
        "Tax": Tax,
      };
       final String apiUrl=api_perfix+"/api/houseresource/AddHouseStep2";
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
