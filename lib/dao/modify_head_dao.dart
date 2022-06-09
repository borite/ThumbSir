import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:new_lianghua_app/model/common_result_model.dart';

import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class ModifyHeadDao {
  static Future<CommonResult> modifyHead(String userHeadUrl,String userID) async {
    var client = http.Client();
    final response= await client.post(
        Uri.http(apiPerFix,'/api/usercenter/ModifyUserHead'),
        body: {
          "userHeadUrl": userHeadUrl,
          "userID": userID,
        });
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      //print(response.body);
      return commonResultFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}