import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String api_perfix=CommonVars.apiPrefix;

class RefuseConnectDao{
    static Future<CommonResult> refuseConnect(
        String id,
    ) async {
       final String apiUrl=api_perfix+"api/contact/RefuseConnect?userID="+id;
       final response= await http.post(apiUrl);
       if(response.statusCode==200){
         return commonResultFromJson(response.body);
       }else{
//         return null;
         throw Exception(response.body);
       }
    }
}
