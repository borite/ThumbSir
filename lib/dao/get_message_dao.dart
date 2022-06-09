import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:new_lianghua_app/model/get_message_model.dart';

import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class GetMessageDao {
  static Future<GetMessage> getMessage(String userID,String msgType,String pageIndex,String pageSize) async {
    final response = await http.get(
        Uri.http(
          apiPerFix,
          '/api/commontools/GetMessage',
         {'UserID':userID,'MsgType':msgType,'pageIndex':pageIndex,'pageSize':pageSize}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getMessageFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}