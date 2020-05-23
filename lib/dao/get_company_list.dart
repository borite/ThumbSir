import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/company_list.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class GetCompanyListDao {
  static Future<CompanyList> httpGetCompanyList() async {
    final response = await http.get(apiPerfix+'api/User/GetCompanyList');
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      //print(response.body);
      return companyListFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}