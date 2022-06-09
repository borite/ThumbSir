import 'dart:async';
import 'package:http/http.dart' as http;
import '../model/phone_verify_code_model.dart';
import '../utils/common_vars.dart';

const String apiPerFix=Url.apiPrefix;

class PhoneVerifyCodeDao{
    static Future<PhoneVerifyCode> sendSms(String phoneNum) async {
      var client = http.Client();
      final response= await client.post(
          Uri.http(apiPerFix,'/api/commontools/SendVerifyCode'),
          body: {"phoneNum":phoneNum});
       if(response.statusCode==200){
         final String resString=response.body;
         final String? setCookie=response.headers['set-cookie'];
         PhoneVerifyCode t= phoneVerifyCodeFromJson(resString);
         t.cookie=setCookie!;
         return t;
       }else{
         throw Exception(response.body);
       }
    }
}



