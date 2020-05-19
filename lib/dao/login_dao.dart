import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

// 接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class LoginDao {
  static Future<LoginModel> doUserLogin(String _password,String _phone) async {
    final response = await http.post(apiPerfix+'api/User/UserLogin',body: {
      "Phone": _phone,
      "Password": _password,
    });
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      print('成功');
//      return userLoginFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}

