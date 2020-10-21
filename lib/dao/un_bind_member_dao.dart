import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class UnBindMemberDao {
  static Future<CommonResult> unbind(String userID,String userLevel,String companyID) async {
    final response = await http.post(apiPerfix+'api/User/UnBindMember',body: {
      "userID": userID,
      "UserLevel":userLevel,
      "CompanyID":companyID,
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