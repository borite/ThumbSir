import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:new_lianghua_app/model/common_result_model.dart';

import '../utils/common_vars.dart';

const String apiPerFix=Url.apiPrefix;

class ModifyUserPwdDao{
    static Future<CommonResult> modifyPwd(String newPassword,String oldPassword,userID) async {
      var client = http.Client();
      final response= await client.post(
          Uri.http(apiPerFix,'/api/usercenter/ModifyUserPwd'),
          body: {
             "newPassword":newPassword,
             "oldPassword":oldPassword,
             "userID":userID
           });
       if(response.statusCode==200){
         final String resString=response.body;
         CommonResult t= commonResultFromJson(resString);
         return t;
       }else{
         throw Exception(response.body);
       }
    }
}



