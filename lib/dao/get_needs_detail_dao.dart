import 'dart:async';
import 'package:ThumbSir/model/get_needs_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.testApiPrefix;

class GetNeedsDetailDao {
  static Future<GetNeedsDetail> httpGetNeedsDetail(String cid) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/customerfrom/GetNeedsDetail',
            {'cid':cid}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getNeedsDetailFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}