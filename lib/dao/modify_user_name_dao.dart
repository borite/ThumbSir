import 'dart:async';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String api_perfix=CommonVars.apiPrefix;

class ModifyUserNameDao{
    static Future<CommonResult> modifyName(String userID,String newName) async {
       final String apiUrl=api_perfix+"api/usercenter/ModifyUserName";
       final response= await http.post(apiUrl,body: {"UserName":newName,"UserID":userID});
       if(response.statusCode==200){
         final String resString=response.body;
         CommonResult t= commonResultFromJson(resString);
         return t;
       }else{
         return null;
       }
    }
}



