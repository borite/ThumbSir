import 'dart:async';
import 'package:ThumbSir/model/house_list_search_info_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

import '../model/get_house_list_model.dart';

//接口地址前缀
const String apiPerFix=Url.testApiPrefix;

class GetHouseListByFilterSearchDao {
  static Future<HouseListSearchInfo> httpGetHouseListByFilterSearch(
      String userID,
      String companyId,
      int bstate,
      int tradeType,
      int houseType,
      int orderType,
      int pageIndex,
      int pageSize
      ) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/houseresource/GetHouseListByCondition',
            {
              'userID':userID,
              'companyID':companyId,
              'bstate':bstate,
              'tradeType':tradeType,
              'houseType':houseType,
              'orderType':orderType,
              'pageIndex':pageIndex,
              'pageSize':pageSize
            }.map((key, value) => MapEntry(key, value.toString())),)
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return houseListSearchInfoFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}