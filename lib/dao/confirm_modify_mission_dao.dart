import 'dart:async';
import 'package:http/http.dart' as http;
import '../model/user_select_mission_model.dart';
import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class ConfirmModifyDao {
  static Future<UserSelectMission> modifyMission(
      String oldMissionId,
      String companyId,
      String userId,
      String adminTaskId,
      String userLevel,
      String planningStartTime,
      String planningEndTime,
      String stars,
      String planningCount,
      String address,
      String remark,
      ) async {
    var client = http.Client();
    final response= await client.post(
        Uri.http(apiPerFix,'/api/mission/ConfirmModify'),
        body: {
          "OldMissionID":oldMissionId,
          "CompanyID": companyId,
          "userID": userId,
          "AdminTaskID":adminTaskId,
          "UserLevel":userLevel,
          "PlanningStartTime":planningStartTime,
          "PlanningEndTime":planningEndTime,
          "Stars":stars,
          "PlanningCount":planningCount,
          "Address":address,
          "Remark":remark,
        });
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      //print(response.body);
      return userSelectMissionFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}