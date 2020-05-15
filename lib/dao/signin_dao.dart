import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/model/signin_model.dart';

// 接口地址
const URL = 'http://47.104.20.6:10086/api/';

class SigninDao {
  static Future<SigninModel> fetch() async {
    final response = await http.post(URL+'User/UserRegister');
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return SigninModel.fromJson(result);
    }else{
      throw Exception('加载失败');
    }
  }
}

