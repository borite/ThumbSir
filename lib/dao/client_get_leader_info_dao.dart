import 'dart:async';
import 'package:ThumbSir/model/client_get_leader_info_model.dart';
import 'package:ThumbSir/model/get_leader_info_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.testApiPrefix;

class ClientGetLeaderInfoDao {
  static Future<ClientGetLeaderInfo> httpClientGetLeaderInfo(
      String leaderID,
      String companyID,
    ) async {
    final response = await http.get(apiPerfix+'api/customerfrom/GetLeaderInfo?LeaderID='+leaderID+'&CompanyID='+companyID);
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return clientGetLeaderInfoFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}