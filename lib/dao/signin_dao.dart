import 'dart:async';
import 'package:ThumbSir/model/sing_in_result.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

// 接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class SigninDao {
  static Future<SingInResult> doUserReg(String _userName,String _password,String _phone,String _verifyCode,String _cookie ) async {
    final response = await http.post(apiPerfix+'api/User/UserRegister',body: {
      "UserName": _userName,
      "Phone": _phone,
      "Password": _password,
      "yzm": _verifyCode,
    },headers: {'Cookie':_cookie});
    if(response.statusCode == 200){
      return singInResultFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}

