import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String apiPerFix=Url.testApiPrefix;

class AddHouseStep3Dao{
    static Future<CommonResult> addHouseStep3(
        String HouseID,
        bool IsInSchoolArea,
        String School,
        String Traffic,
        String Entertainment,
        String Hospital,
        String Bank,
        String Park,
        String OtherLabel,
        String OtherIntro,
    ) async {
      //组织要发送给APi的键值对
      var _body={
        "HouseID":HouseID,
        "IsInSchoolArea":IsInSchoolArea,
        "School": School,
        "Traffic": Traffic,
        "Entertainment": Entertainment,
        "Hospital": Hospital,
        "Bank": Bank,
        "Park": Park,
        "OtherLabel": OtherLabel,
        "OtherIntro": OtherIntro,
      };
      var client = http.Client();
      final response= await client.post(
          Uri.http(apiPerFix,'/api/order/AddNewOrder'),
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
