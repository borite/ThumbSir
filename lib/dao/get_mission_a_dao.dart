import 'dart:async';
import 'package:http/http.dart' as http;

import '../model/get_mission_a_model.dart';
import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class GetMissionADao {
  static Future<GetMissionA> getMissionA(String userId, String leaderId,String userLevel,String companyId,) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/mission/GetMissionA',
            {'UserID':userId,'LeaderID':leaderId,'UserLevel':userLevel,'CompanyID':companyId}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getMissionAFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}