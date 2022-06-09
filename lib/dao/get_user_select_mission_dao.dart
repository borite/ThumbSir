import 'dart:async';
import 'package:http/http.dart' as http;
import '../model/get_user_select_mission_model.dart';
import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class GetUserSelectMissionDao {
  static Future<GetUserSelectMission> getMissions(
      String userID,
      String userLevel,
      String date,
      ) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/mission/GetUserSelectMission',
            {'UserID':userID,'UserLevel':userLevel,'date':date}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getUserSelectMissionFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}