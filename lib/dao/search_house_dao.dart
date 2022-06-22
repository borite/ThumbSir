import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

import '../model/get_house_list_model.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class SearchHouseDao {
  static Future<GetHouseList> httpSearchHouse(
      String name,
      String companyID,
    ) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/houseresource/SearchHouse',
            {'name':name,'companyID':companyID}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getHouseListFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}