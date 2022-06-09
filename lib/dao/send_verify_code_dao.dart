import 'dart:async';
import 'package:http/http.dart' as http;
import '../model/send_verify_code_model.dart';
import '../utils/common_vars.dart';

const String apiPerFix=Url.apiPrefix;

class SendVerifyCodeDao{
    static Future<SendVerifyCode> sendSms(String phoneNum) async {
      var client = http.Client();
      final response= await client.post(
          Uri.http(apiPerFix,'/api/User/RegisterCheckNum'),
          body: {"phoneNum":phoneNum});
       if(response.statusCode==200){
         final String resString=response.body;
         final String? setCookie=response.headers['set-cookie'];
         SendVerifyCode t= sendVerifyCodeFromJson(resString);
         t.cookie=setCookie!;
         return t;
       }else{
         throw Exception(response.body);
       }
    }
}



