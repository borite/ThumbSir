import 'dart:async';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String apiPerFix=Url.apiPrefix;

class AddCareCustomerActionDao{
    static Future<CommonResult> addCareAction(
        String mid,
        String reason,
        String giftName,
        String remark,
        String price,
        String time,
    ) async {

      //组织要发送给APi的键值对
      var _body={
        "MID":mid,
        "GiftReason": reason,
        "GiftName": giftName,
        "GiftRemark": remark,
        "GiftPrice": price,
        "AddTime": time,
      };
      var client = http.Client();
      final response= await client.post(
          Uri.http(apiPerFix,'/api/customer/AddCareCustomerAction'),
          body:_body
       );
       if(response.statusCode==200){
         return commonResultFromJson(response.body);
       }else{
         throw Exception(response.body);
       }
    }
}

