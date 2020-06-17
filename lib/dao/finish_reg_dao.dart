import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class finishRegDao {
  static Future<CommonResult> httpPostFinishReg(String uid,String cmID,String ulevel,String uSection) async {
    final response = await http.post(apiPerfix+'api/User/RegUpdateUser',body: {
      "UserPID": uid,
      "CompanyID": cmID,
      "UserLevel": ulevel,
      "UserSection": uSection
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