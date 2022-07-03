import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';
import '../model/get_combin_customer_info_model.dart';

//接口地址前缀
const String apiPerFix=Url.testApiPrefix;

class GetCombinCustomerInfoDao {
  static Future<GetCombinCustomerInfo> httpGetCombinCustomerInfo(String cId) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/houseresource/GetCombinCustomerInfo',
            {'customerID':cId}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getCombinCustomerInfoFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}