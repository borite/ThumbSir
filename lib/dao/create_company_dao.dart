import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class CreateCompanyDao {
  static Future<CommonResult> httpPostCreateCompany(String _cname,String _ccode,String _levelcount,String _province,String _city) async {
    final response = await http.post(apiPerfix+'api/User/CreateCompany',body: {
      "CompanyName": _cname,
      "CreditCode": _ccode,
      "LevelCount": _levelcount,
      "Province": _province,
      "city": _city
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