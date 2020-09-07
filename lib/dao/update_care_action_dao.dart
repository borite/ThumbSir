import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String api_perfix=CommonVars.apiPrefix;

class UpdateCareActionDao{
    static Future<CommonResult> addCareAction(
        String id,
        String mid,
        String reason,
        String giftName,
        String remark,
        String price,
        String time,
    ) async {

      //组织要发送给APi的键值对
      var _body={
        "ID":id,
        "MID":mid,
        "GiftReason": reason,
        "GiftName": giftName,
        "GiftRemark": remark,
        "GiftPrice": price,
        "AddTime": time,
      };
      print(json.encode(_body));
       final String apiUrl=api_perfix+"api/customer/UpdateCareAction";
       final response= await http.post(apiUrl,
           body: _body
       );
       if(response.statusCode==200){
         return commonResultFromJson(response.body);
       }else{
         throw Exception(response.body);
       }
    }
}

