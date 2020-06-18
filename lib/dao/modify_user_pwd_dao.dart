import 'dart:async';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String api_perfix=CommonVars.apiPrefix;

class ModifyUserPwdDao{
    static Future<CommonResult> modifyPwd(String newPassword,String oldPassword,userID) async {
       final String apiUrl=api_perfix+"api/usercenter/ModifyUserPwd";
       final response= await http.post(apiUrl,body: {
         "newPassword":newPassword,
         "oldPassword":oldPassword,
         "userID":userID
       });
       if(response.statusCode==200){
         final String resString=response.body;
         CommonResult t= commonResultFromJson(resString);
         return t;
       }else{
         return null;
       }
    }
}



