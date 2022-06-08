import 'dart:async';
import 'package:ThumbSir/model/get_house_info_model.dart';
import 'package:ThumbSir/model/get_next_level_users_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.testApiPrefix;

class GetHouseInfoDao {
  static Future<GetHouseInfo> getHouseInfo(String houseId) async {
    final response = await http.get(apiPerfix+'api/houseresource/GetHouseInfo?houseID='+houseId);
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getHouseInfoFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}