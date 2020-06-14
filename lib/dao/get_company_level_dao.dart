import 'dart:async';
import 'package:ThumbSir/model/company_level_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class GetCompanyLevelDao {
  static Future<CompanyLevelList> httpGetCompanyLevel(String copyID) async {
    final response = await http.get(apiPerfix+'api/User/GetCompanyLevel?CompanyID='+copyID);
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return companyLevelListFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}