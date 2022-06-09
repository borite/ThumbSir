import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:new_lianghua_app/model/send_verify_code_model.dart';

import '../utils/common_vars.dart';

const String apiPerFix=Url.apiPrefix;

class ModifyPhoneStepOneDao{
    static Future<SendVerifyCode> modifyPhone1(String password,String phoneNum,String userID) async {
      var client = http.Client();
      final response= await client.post(
          Uri.http(apiPerFix,'/api/usercenter/ModifyPhoneStep1'),
          body: {
             "Password":password,
             "PhoneNum":phoneNum,
             "userID":userID
           });
       if(response.statusCode==200){
         final String resString=response.body;
         final String? setCookie=response.headers['set-cookie'];
         SendVerifyCode t= sendVerifyCodeFromJson(resString);
         t.cookie=setCookie;
         return t;
       }else{
         throw Exception(response.body);
       }
    }
}



