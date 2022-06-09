import 'dart:async';
import 'package:http/http.dart' as http;

import '../model/get_single_mission_data_model.dart';
import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class GetSingleMissionDataDao {
  static Future<GetSingleMissionData> httpGetSingleMissionData(
      String taskID,
      String leaderID,
      String companyID,
      String startDate,
      String endDate
    ) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/analysis/GetSingleMissionData',
            {'taskID':taskID,'LeaderID':leaderID,'companyID':companyID,'startDate':startDate,'endDate':endDate}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getSingleMissionDataFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}