import 'dart:async';
import 'package:ThumbSir/model/get_mission_s_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class GetMissionSDao {
  static Future<GetMissionS> getMissionS(String userId, String userLevel,String companyId,) async {
    final response = await http.get(apiPerfix+'api/mission/GetMissionS?UserID='+userId+'&UserLevel='+userLevel+'&CompanyID='+companyId);
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getMissionSFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}
