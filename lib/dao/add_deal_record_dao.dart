import 'dart:async';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class AddDealRecordDao {
  static Future<CommonResult> addDealRecord(
      String mid,
      String finishTime,
      String dealReason,
      String address,
      String dealArea,
      String dealPrice,
      String dealRemark,
    ) async {
    var client = http.Client();
    final response= await client.post(
        Uri.http(apiPerFix,'/api/customer/AddDealRecord'),
        body: {
          "MID": mid,
          "FinishTime":finishTime,
          "DealReason":dealReason,
          "Address":address,
          "DealArea":dealArea,
          "DealPrice":dealPrice,
          "DealRemark":dealRemark,
        });
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      //print(response.body);
      return commonResultFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}