import 'dart:async';
import 'package:http/http.dart' as http;
import '../model/get_user_by_phone_model.dart';
import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class GetUserByPhoneDao {
  static Future<GetUserByPhone> getUserByPhone(String phoneNum) async {
    var client = http.Client();
    final response= await client.post(
        Uri.http(apiPerFix,'/api/commontools/GetUserByPhone'),
        body: {
          "phoneNum": phoneNum,
        });
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      //print(response.body);
      return getUserByPhoneFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}