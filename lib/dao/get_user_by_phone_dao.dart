import 'dart:async';
import 'package:ThumbSir/model/getuser_byphone_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class GetUserByPhoneDao {
  static Future<GetUserByPhone> getUserByPhone(String phoneNum) async {
    final response = await http.post(apiPerfix+'api/commontools/GetUserByPhone',body: {
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