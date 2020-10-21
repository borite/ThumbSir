import 'dart:async';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String api_perfix=CommonVars.apiPrefix;

class CheckVerifyCodeDao{
    static Future<CommonResult> checkCode(String code,String cookie) async {
       final String apiUrl=api_perfix+"api/commontools/CheckVerifyCode";
       final response= await http.post(apiUrl,body: {"":code},headers: {'Cookie':cookie});
       if(response.statusCode==200){
         final String resString=response.body;
         CommonResult t= commonResultFromJson(resString);
         return t;
       }else{
         return null;
       }
    }
}



