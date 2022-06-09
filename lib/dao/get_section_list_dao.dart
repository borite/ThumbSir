import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:new_lianghua_app/model/section_list_model.dart';

import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class GetSectionListDao {
  static Future<SectionListModel> httpGetSectionList(String comid,String level) async {
    final response = await http.get(
        Uri.http(
        apiPerFix,
        '/api/company/GetSectionList',
        {'comid':comid,'level':level}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return sectionListModelFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}