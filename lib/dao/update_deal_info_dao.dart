import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String apiPerFix=Url.apiPrefix;

class UpdateDealInfoDao{
    static Future<CommonResult> updateDealInfo(
        String id,
        String mid,
        String reason,
        String time,
        String address,
        String area,
        String price,
        String remark,
    ) async {

      //组织要发送给APi的键值对
      var _body={
        "DealID":id,
        "MID":mid,
        "DealReason": reason,
        "FinishTime": time,
        "Address": address,
        "DealArea": area,
        "DealPrice": price,
        "DealRemark":remark,
      };
      var client = http.Client();
      final response= await client.post(
          Uri.http(apiPerFix,'/api/customer/UpdateDealInfo'),
          body: _body
       );
       if(response.statusCode==200){
         return commonResultFromJson(response.body);
       }else{
         throw Exception(response.body);
       }
    }
}

