import 'dart:async';
import 'package:ThumbSir/model/get_last_level_customer_num_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class GetLastLevelCustomerNumDao {
  static Future<GetLastLevelCustomerNum> httpGetLastLevelCustomerNum(
      String leaderID,
      String companyID,
    ) async {
    final response = await http.get(apiPerfix+'api/customer/GetLastLevelCustomerNum?LeaderID='+leaderID+'&CompanyID='+companyID);
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getLastLevelCustomerNumFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}