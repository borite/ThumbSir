import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/model/userreg_model.dart';
import 'package:ThumbSir/utils/common_vars.dart';

// 接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class SigninDao {
  static Future<UserReg> doUserReg(String _userName,String _password,String _phone,String _verifyCode, String _companyID,String _cookie ) async {
    final response = await http.post(apiPerfix+'api/User/UserRegister',body: {
      "UserName": _userName,
      "Phone": _phone,
      "Password": _password,
      "yzm": _verifyCode,
      "CompanyID": _companyID
    },headers: {'Cookie':_cookie});
    if(response.statusCode == 200){
      return userRegFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}

