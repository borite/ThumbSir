import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:new_lianghua_app/model/common_result_model.dart';

import '../utils/common_vars.dart';

const String apiPerFix=Url.apiPrefix;

class ModifyUserNameDao{
    static Future<CommonResult> modifyName(String userID,String newName) async {

      var client = http.Client();
      final response= await client.post(
          Uri.http(apiPerFix,'/api/usercenter/ModifyUserName'),
          body: {"UserName":newName,"UserID":userID});
       if(response.statusCode==200){
         final String resString=response.body;
         CommonResult t= commonResultFromJson(resString);
         return t;
       }else{
         throw Exception(response.body);
       }
    }
}



