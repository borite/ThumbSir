import 'dart:async';
import 'package:ThumbSir/model/get_last_level_house_resource_model.dart';
import 'package:http/http.dart' as http;
import '../model/get_last_level_members_model.dart';
import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class GetLastLevelHouseResourceDao {
  static Future<GetLastLevelHouseResource> httpGetLastLevelHouseResource(
      String leaderID,
      String companyID,
    ) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/houseresource/GetLastLevelHouseResource',
            {'LeaderID':leaderID,'CompanyID':companyID}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getLastLevelHouseResourceFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}