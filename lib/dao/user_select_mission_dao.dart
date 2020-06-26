import 'dart:async';
import 'package:ThumbSir/model/user_select_mission_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class UserSelectMissionDao {
  static Future<UserSelectMission> selectMission(
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
    final response = await http.post(apiPerfix+'api/mission/UserSelectMission',body: {
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