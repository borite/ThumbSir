import 'dart:async';
import 'package:http/http.dart' as http;
import '../model/login_result_model.dart';
import '../utils/common_vars.dart';

// 接口地址前缀
const String apiPerFix=Url.testApiPrefix;

class LoginResultDao {

  static Future<LoginResult> doUserLogin(String _password,String _phone) async {
    var client = http.Client();
    final response= await client.post(
        Uri.http(apiPerFix,'/api/User/UserLogin'),
        body: {"Phone": _phone, "Password": _password,});
    if(response.statusCode == 200){
      return loginResultFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}

