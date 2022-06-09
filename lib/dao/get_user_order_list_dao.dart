import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:new_lianghua_app/model/get_user_order_list_model.dart';
import 'package:new_lianghua_app/utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class GetUserOrderListDao {
  static Future<GetUserOrderList> getUserOrderList(String userId) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/usercenter/GetUserOrderList',
            {'UserID':userId}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getUserOrderListFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}