import 'dart:async';
import 'package:ThumbSir/model/login_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String api_perfix=CommonVars.apiPrefix;

class TokenCheckDao{
    static Future<LoginResult> tokenCheck(String Token) async {
       final String apiUrl=api_perfix+"api/User/TokenCheck";
       final response= await http.post(apiUrl,body: {"Token":Token});
       if(response.statusCode==200){
         final String resString=response.body;
         LoginResult t= loginResultFromJson(resString);
         return t;
       }else{
         return null;
       }
    }
}



