import 'dart:async';
import 'package:ThumbSir/model/find_user_result_model.dart';
import 'package:ThumbSir/model/getuser_byphone_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

const String api_perfix=CommonVars.apiPrefix;

class GetUserByPhoneDao{
  // GetUserByPhone
    static Future<FindUserResult> findUserByPhone(String phoneNum) async {
       final String apiUrl=api_perfix+"api/commontools/GetUserByPhone";
       final response= await http.post(apiUrl,body: {
         "phoneNum":phoneNum
       });
       if(response.statusCode==200){
         final String resString=response.body;
         final String setCookie=response.headers['set-cookie'];
         FindUserResult t= findUserResultFromJson(resString);
//         t.cookie=setCookie;
//         print('setCookie');
//         print(setCookie);
         return t;
       }else{
         return null;
       }
    }
}



