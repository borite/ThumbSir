
import 'dart:async';
import 'package:ThumbSir/model/test_vi_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

// 接口地址前缀
const String apiPerFix=Url.apiPrefix;


class TestVIDao {
  static Future<TestVi> doVI(String _imgurl,bool _isapple) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/commontools/TestVI',
            {'imgUrl':_imgurl,"isApple":_isapple.toString()}
        )
    );
    if(response.statusCode == 200){
      return testViFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}