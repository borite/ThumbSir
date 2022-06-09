import 'dart:async';
import 'package:ThumbSir/model/search_client_customer_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.testApiPrefix;

class SearchClientCustomerDao {
  static Future<SearchClientCustomer> searchClientCustomer(
      String keyword,
      String userID,
    ) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/customerfrom/SearchCustomer',
            {'keyword':keyword,'userID':userID}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return searchClientCustomerFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}