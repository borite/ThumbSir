import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

import '../model/get_house_list_model.dart';

//接口地址前缀
const String apiPerFix=Url.testApiPrefix;

class GetHouseListDao {
  static Future<GetHouseList> httpGetHouseList(String companyId,String pageIndex,String pageSize) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/houseresource/GetHouseList',
            {
              'companyID':companyId,'pageIndex':pageIndex,'pageSize':pageSize
            })
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