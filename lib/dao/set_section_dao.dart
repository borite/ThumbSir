import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class setSecionDao {
  static Future<CommonResult> httpPostSection(String cid,String s1,String s2,String s3,String s4,String s5,String s6) async {
    final response = await http.post(apiPerfix+'api/User/SetLevelSection',body: {
      "CompanyID": cid,
      "Section1": s1,
      "Section2": s2,
      "Section3": s3,
      "Section4": s4,
      "Section5": s5,
      "Section6": s6
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