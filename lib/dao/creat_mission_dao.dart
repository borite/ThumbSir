import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class CreatMissionDao {
  static Future<CommonResult> creatMission(
      String companyID,
      String userID,
      String selectTaskIDs,
      String minCount,
      String userLevel,
      List missionContent
  ) async {
    final response = await http.post(apiPerfix+'api/mission/CreatMission',body: {
      "CompanyID": companyID,
      "userID": userID,
      "SelectTaskIDs":selectTaskIDs,
      "MinCount":minCount,
      "UserLevel":userLevel,
      "MissionContent":json.encode(missionContent)
    });
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return commonResultFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}