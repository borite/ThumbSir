import 'dart:async';
import 'package:http/http.dart' as http;
import '../model/common_result_model.dart';
import '../utils/common_vars.dart';

const String apiPerFix=Url.apiPrefix;

class RefuseConnectDao{
    static Future<CommonResult> refuseConnect(
        String id,
    ) async {
      var client = http.Client();
      final response= await client.post(
          Uri.http(apiPerFix,'/api/contact/RefuseConnect'),
          body: {
            'userID':id
          });
       if(response.statusCode==200){
         return commonResultFromJson(response.body);
       }else{
//         return null;
         throw Exception(response.body);
       }
    }
}

