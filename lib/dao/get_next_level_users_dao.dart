import 'dart:async';
import 'package:http/http.dart' as http;

import '../model/get_next_level_users_model.dart';
import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class GetNextLevelUsersDao {
  static Future<GetNextLevelUsers> getNextLevelUsers(String userId) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/contact/GetNextLevelUsers',
            {'UserID':userId}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getNextLevelUsersFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}