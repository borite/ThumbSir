import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:new_lianghua_app/model/company_list_model.dart';

import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=Url.apiPrefix;

class GetCompanyListDao {
  static Future<CompanyList> httpGetCompanyList() async {
    final response = await http.get(
        Uri.http(
          apiPerfix,
          '/api/User/GetCompanyList'
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return companyListFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}