import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.testApiPrefix;

class UpdateCustomerNeedDao {
  static Future<CommonResult> updateCustomerNeed(
      String id,
      String CustomerID,
      String MainNeed,
      String NeedReason,
      String CoreNeedOne,
      String CoreNeedOneRemark,
      String CoreNeedTwo,
      String CoreNeedTwoRemark,
      String CoreNeedThree,
      String CoreNeedThreeRemark,
      String OtherNeed,
      String OtherNeedRemark,
      String State,
      ) async {
    var client = http.Client();
    final response= await client.post(
        Uri.http(apiPerFix,'/api/customerfrom/UpdateCustomerNeed'),
        body: {
          "ID":id,
          "CustomerID": CustomerID,
          "MainNeed": MainNeed,
          "NeedReason": NeedReason,
          "CoreNeedOne": CoreNeedOne,
          "CoreNeedOneRemark": CoreNeedOneRemark,
          "CoreNeedTwo": CoreNeedTwo,
          "CoreNeedTwoRemark":CoreNeedTwoRemark,
          "CoreNeedThree": CoreNeedThree,
          "CoreNeedThreeRemark": CoreNeedThreeRemark,
          "OtherNeed": OtherNeed,
          "OtherNeedRemark": OtherNeedRemark,
          "State": State
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

