import 'dart:async';
import 'package:ThumbSir/model/phoneverifycode_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String api_perfix=CommonVars.apiPrefix;

class PhoneVerifyCodeDao{
    static Future<PhoneVerifyCode> sendSms(String phoneNum) async {
       final String apiUrl=api_perfix+"api/commontools/SendVerifyCode";
       final response= await http.post(apiUrl,body: {"phoneNum":phoneNum});
       if(response.statusCode==200){
         final String resString=response.body;
         final String setCookie=response.headers['set-cookie'];
         PhoneVerifyCode t= phoneVerifyCodeFromJson(resString);
         t.cookie=setCookie;
         return t;
       }else{
         return null;
       }
    }
}



