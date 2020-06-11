import 'dart:async';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:ThumbSir/model/phoneverifycode_model.dart';
import 'package:ThumbSir/model/retruve_user_pwd_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String api_perfix=CommonVars.apiPrefix;

class RetruveUserPwdDao{
    static Future<CommonResult> findPwd(String newPassword,userID) async {
       final String apiUrl=api_perfix+"api/usercenter/RetruveUserPwd";
       final response= await http.post(apiUrl,body: {"newPassword":newPassword,"userID":userID});
       if(response.statusCode==200){
         final String resString=response.body;
         CommonResult t= commonResultFromJson(resString);
         return t;
       }else{
         return null;
       }
    }
}



