import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:new_lianghua_app/model/company_level_list_model.dart';

import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class GetCompanyLevelDao {
  static Future<CompanyLevelList> httpGetCompanyLevel(String cID) async {
    final response = await http.get(
        Uri.http(
          apiPerFix,
          '/api/User/GetCompanyLevel',
          {'CompanyID':cID}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return companyLevelListFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}