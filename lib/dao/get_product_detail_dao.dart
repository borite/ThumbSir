import 'dart:async';
import 'package:http/http.dart' as http;
import '../model/get_product_detail_model.dart';
import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.testApiPrefix;

class GetProductDetailDao {
  static Future<GetProductDetail> httpGetProductDetail(String pid) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/order/GetProductDetail',
            {'pid':pid}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getProductDetailFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}