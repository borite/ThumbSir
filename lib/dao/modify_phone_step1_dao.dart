import 'dart:async';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:ThumbSir/model/sendverifycode_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String api_perfix=CommonVars.apiPrefix;

class ModifyPhoneStepOneDao{
    static Future<SendVerifyCode> modifyPhone1(String password,String phoneNum,String userID) async {
       final String apiUrl=api_perfix+"api/usercenter/ModifyPhoneStep1";
       final response= await http.post(apiUrl,body: {
         "Password":password,
         "PhoneNum":phoneNum,
         "userID":userID
       });
       if(response.statusCode==200){
         final String resString=response.body;
         final String setCookie=response.headers['set-cookie'];
         SendVerifyCode t= sendVerifyCodeFromJson(resString);
         t.cookie=setCookie;
         return t;
       }else{
         return null;
       }
    }
}



