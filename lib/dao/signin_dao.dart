import 'dart:async';
import 'package:http/http.dart' as http;
import '../model/sign_in_result.dart';
import '../utils/common_vars.dart';

// 接口地址前缀
const String apiPerFix=Url.apiPrefix;

class SigninDao {
  static Future<SingInResult> doUserReg(String _userName,String _password,String _phone,String _verifyCode,String _cookie ) async {
    var client = http.Client();
    final response= await client.post(
        Uri.http(apiPerFix,'/api/User/UserRegister'),
        body: {
          "UserName": _userName,
          "Phone": _phone,
          "Password": _password,
          "yzm": _verifyCode,
    },headers: {'Cookie':_cookie});
    if(response.statusCode == 200){
      return signInResultFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}

