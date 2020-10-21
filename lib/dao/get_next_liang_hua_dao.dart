import 'dart:async';
import 'package:ThumbSir/model/get_next_liang_hua_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class GetNextLiangHuaDao {
  static Future<GetNextLiangHua> httpGetNextLiangHua(
      String leaderID,
      String companyID,
      String leaderSection,
      String date
    ) async {
    final response = await http.get(apiPerfix+'api/analysis/GetNextLiangHua?leaderID='+leaderID+'&companyID='+companyID+'&LeaderSection='+leaderSection+'&date='+date);
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getNextLiangHuaFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}