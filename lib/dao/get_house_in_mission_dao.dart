import 'dart:async';
import 'package:ThumbSir/model/get_house_in_mission_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.testApiPrefix;

class GetHouseInMissionDao {
  static Future<GetHouseInMission> httpGetHouseInMission(String missionId) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/houseresource/GetHouseInMission',
            {'missionID':missionId}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getHouseInMissionFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}