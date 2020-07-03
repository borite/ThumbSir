import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class SendMessageDao {
  static Future<CommonResult> sendMessage(String fromUserID,String toUserID,String msgTitle,String msgContent,String msgType) async {
    final response = await http.post(apiPerfix+'api/commontools/SendMessage',body: {
      "FromUserID": fromUserID,
      "toUserID": toUserID,
      "MsgTitle":msgTitle,
      "MsgContent":msgContent,
      "MsgType":msgType,
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