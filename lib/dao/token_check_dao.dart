import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:new_lianghua_app/model/login_result_model.dart';
import '../utils/common_vars.dart';

const String apiPerFix=Url.apiPrefix;

class TokenCheckDao{
    static Future<LoginResult> tokenCheck(String token) async {
      var client = http.Client();
       final response= await client.post(
           Uri.http(apiPerFix,'/api/User/TokenCheck'),
           body: {"Token":token});
       if(response.statusCode==200){
         final String resString=response.body;
         LoginResult t= loginResultFromJson(resString);
         return t;
       }else{
         throw Exception(response.body);
       }
    }
}



