import 'dart:async';
import 'package:ThumbSir/model/get_customer_info_model.dart';
import 'package:ThumbSir/model/get_user_detail_by_id_model.dart';
import 'package:ThumbSir/model/get_user_info_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.testApiPrefix;

class GetUserInfoDao {
  static Future<GetUserInfo> getUserInfo(
      String id
    ) async {
    final response = await http.get(
        apiPerfix+'api/backmanage/GetUserInfo?userID='+id
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getUserInfoFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}