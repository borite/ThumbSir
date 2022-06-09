import 'dart:async';
import 'package:http/http.dart' as http;
import '../model/shangquan_payfor_model.dart';
import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class ShangQuanPayForDao {
  static Future<ShangQuanPayFor> httpShangquanPayfor(
      String squserId,
      String cycledays,
      String money
    ) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/order/ShangQuanPayFor',
            {'squserid':squserId,'cycledays':cycledays,'money':money}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return shangQuanPayForFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}