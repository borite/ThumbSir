import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String apiPerFix=Url.apiPrefix;

class DeleteFamilyMemberInfoDao{
    static Future<CommonResult> deleteFamilyMemberInfo(
        String id,
    ) async {
      var client = http.Client();
      final response= await client.post(
          Uri.http(apiPerFix,'/api/customer/DeleteFamilyMemberInfo'),
          body: {"ID": id});
       if(response.statusCode==200){
         return commonResultFromJson(response.body);
       }else{
//         return null;
         throw Exception(response.body);
       }
    }
}

