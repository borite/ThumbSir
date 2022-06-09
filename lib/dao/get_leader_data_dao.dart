import 'dart:async';
import 'package:http/http.dart' as http;

import '../model/get_leader_data_model.dart';
import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class GetLeaderDataDao {
  static Future<GetLeaderData> httpGetLeaderData(
      String leaderID,
      String companyID,
      String date
    ) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/analysis/GetLeaderData',
            {'leaderID':leaderID,'CompanyID':companyID,'date':date}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getLeaderDataFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}