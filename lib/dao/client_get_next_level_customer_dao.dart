import 'dart:async';
import 'package:ThumbSir/model/client_get_next_level_customer_model.dart';
import 'package:http/http.dart' as http;
import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.testApiPrefix;

class ClientGetNextLevelCustomerDao {
  static Future<ClientGetNextLevelCustomer> httpClientGetNextLevelCustomer(
      String leaderID,
      String companyID,
      String leaderSection,
    ) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/customerfrom/GetNextLevelCustomer',
            {'leaderID':leaderID,'companyID':companyID,'LeaderSection':leaderSection}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return clientGetNextLevelCustomerFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}