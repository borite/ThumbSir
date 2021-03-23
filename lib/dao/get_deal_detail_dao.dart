import 'dart:async';
import 'package:ThumbSir/model/company_level_list_model.dart';
import 'package:ThumbSir/model/get_deal_detail_model.dart';
import 'package:ThumbSir/model/get_needs_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.testApiPrefix;

class GetDealDetailDao {
  static Future<GetDealDetail> httpGetDealDetail(String cid) async {
    final response = await http.get(apiPerfix+'api/customerfrom/GetDealDetail?cid='+cid);
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getDealDetailFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}