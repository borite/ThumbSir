import 'dart:async';
import 'package:http/http.dart' as http;

import '../model/get_leader_info_model.dart';
import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class GetLeaderInfoDao {
  static Future<GetLeaderInfo> httpGetLeaderInfo(
      String leaderID,
      String companyID,
    ) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/customer/GetLeaderInfo',
            {'LeaderID':leaderID,'CompanyID':companyID}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getLeaderInfoFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}