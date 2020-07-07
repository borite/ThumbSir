import 'dart:async';
import 'package:ThumbSir/model/get_leader_model.dart';
import 'package:ThumbSir/model/get_next_level_list_model.dart';
import 'package:ThumbSir/model/get_section_data_model.dart';
import 'package:ThumbSir/model/get_single_mission_data_model.dart';
import 'package:ThumbSir/model/section_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class GetSingleMissionDataDao {
  static Future<GetSingleMissionData> httpGetSingleMissionData(
      String taskID,
      String section,
      String companyID,
      String startDate,
      String endDate
    ) async {
    final response = await http.get(apiPerfix+'api/analysis/GetSingleMissionData?taskID='+taskID+'&section='+section+'&companyID='+companyID+'&startDate='+startDate+'&endDate='+endDate);
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getSingleMissionDataFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}