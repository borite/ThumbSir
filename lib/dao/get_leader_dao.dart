import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:new_lianghua_app/model/get_leader_model.dart';
import 'package:new_lianghua_app/utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class GetLeaderDao {
  static Future<GetLeader> httpGetLeader(String companyID,String leaderSection,String leaderLevel) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/contact/GetLeader',
            {'companyID':companyID,'leaderSection':leaderSection,'leaderLevel':leaderLevel}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getLeaderFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}