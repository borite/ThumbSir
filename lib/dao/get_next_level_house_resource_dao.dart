import 'dart:async';
import 'package:ThumbSir/model/get_next_level_resource_model.dart';
import 'package:http/http.dart' as http;

import '../model/get_next_level_users_model.dart';
import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class GetNextLevelHouseResourceDao {
  static Future<GetNextLevelHouseResource> getNextLevelHouseResource(
      String leaderID,
      String companyID,
      String leaderSection
      ) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/houseresource/GetNextLevelHouseResource',
            {'LeaderID':leaderID,'CompanyID':companyID,'LeaderSection':leaderSection}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getNextLevelHouseResourceFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}