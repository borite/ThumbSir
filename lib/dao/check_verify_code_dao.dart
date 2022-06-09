import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:new_lianghua_app/model/common_result_model.dart';
import '../utils/common_vars.dart';

const String apiPerFix=Url.apiPrefix;

class CheckVerifyCodeDao{
    static Future<CommonResult> checkCode(String code,String cookie) async {
      var client = http.Client();
      final response= await client.post(
          Uri.http(apiPerFix,'/api/commontools/CheckVerifyCode'),
          body: {"":code},
          headers: {'Cookie':cookie});
       if(response.statusCode==200){
         final String resString=response.body;
         CommonResult t= commonResultFromJson(resString);
         return t;
       }else{
         throw Exception(response.body);
       }
    }
}



