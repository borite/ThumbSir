import 'dart:async';
import 'package:http/http.dart' as http;
import '../model/get_pay_cycle_list_model.dart';
import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class GetPayCycleListDao {
  static Future<GetPayCycleList> getPayCycleList(String s) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/backmanage/GetPayCycleList',
            {'s':s}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getPayCycleListFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}