import 'dart:async';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class ModifyMissionDao {
  static Future<CommonResult> modifyMission(
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
    final response = await http.post(apiPerfix+'api/mission/ModifyMission',body: {
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
      return commonResultFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}