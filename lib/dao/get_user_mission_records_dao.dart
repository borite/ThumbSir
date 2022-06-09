import 'dart:async';
import 'package:http/http.dart' as http;

import '../model/mission_record_model.dart';
import '../utils/common_vars.dart';
//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class GetMissionRecordDao {
  static Future<GetMissionRecord> missionRecord(
      String userId,
      String missionId,
      String userLevel,
      ) async {

    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/mission/GetMissionPics',
            {'UserID':userId,'MissionID':missionId,'UserLevel':userLevel}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      //print(response.body);
      return getMissionRecordFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}