import 'dart:async';
import 'package:ThumbSir/model/get_leader_model.dart';
import 'package:ThumbSir/model/get_next_level_customer_model.dart';
import 'package:ThumbSir/model/get_next_level_list_model.dart';
import 'package:ThumbSir/model/get_next_liang_hua_model.dart';
import 'package:ThumbSir/model/section_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class GetNextLevelCustomerDao {
  static Future<GetNextLevelCustomer> httpGetNextLevelCustomer(
      String leaderID,
      String companyID,
      String leaderSection,
    ) async {
    final response = await http.get(apiPerfix+'api/customer/GetNextLevelCustomer?leaderID='+leaderID+'&companyID='+companyID+'&LeaderSection='+leaderSection);
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getNextLevelCustomerFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}