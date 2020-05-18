import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/model/sendverifycode_model.dart';
import 'package:ThumbSir/utils/common_vars.dart';

const String api_perfix=CommonVars.apiPrefix;

class SendVerifyCodeDao{
    static Future<SendVerifyCode> sendSms(String phoneNum) async {
       final String apiUrl=api_perfix+"api/User/RegisterCheckNum";
       final response= await http.post(apiUrl,body: {"phone":phoneNum});
       if(response.statusCode==200){
         final String resString=response.body;
         return sendVerifyCodeFromJson(resString);
       }else{
         return null;
       }
    }
}




