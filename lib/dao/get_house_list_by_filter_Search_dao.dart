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
      String houseArea,
      double minPrice,
      double maxPrice,
      double minArea,
      double maxArea,
      int tradeType,
      int schoolHouse,
      String tax,
      String otherLabel,
      String orientation,
      String rooms,
      String elevator,
      String floor,
      String decoration,
      int houseAge,
      String houseType,
      String ownerShip,
      int orderType,
      int pageIndex,
      int pageSize
      ) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/houseresource/FilterSearch',
            {
              'userID':userID,
              'companyID':companyId,
              'bstate':bstate,
              'HouseArea':houseArea,
              'MinPrice': minPrice,
              'MaxPrice': maxPrice,
              'MinArea': minArea,
              'MaxArea': maxArea,
              'tradeType': tradeType,
              'SchoolHouse': schoolHouse,
              'Tax': tax,
              'OtherLabel': otherLabel,
              'Orientation': orientation,
              'Rooms': rooms,
              'Elevator': elevator,
              'Floor': floor,
              'Decoration': decoration,
              'HouseAge': houseAge,
              'HouseType': houseType,
              'OwnerShip': ownerShip,
              'OrderType':orderType,
              'PageIndex':pageIndex,
              'PageSize':pageSize
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