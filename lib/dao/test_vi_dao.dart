
import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/test_vi_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/model/test_vi_model.dart';
import 'package:ThumbSir/utils/common_vars.dart';

// 接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;


class TestVIDao {
  static Future<TestVi> doVI(String _imgurl,bool _isapple) async {
    final response = await http.get(apiPerfix+'api/commontools/TestVI?imgUrl='+_imgurl+"&isApple="+_isapple.toString());
    if(response.statusCode == 200){
      return testViFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}


//生命的意义？只不过是一场体验...恐怖不？~哇哈哈