import 'dart:async';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=Url.apiPrefix;

class AddFamilyMemberInfoDao {
  static Future<CommonResult> addFamilyMemberInfo(
      String mid,
      String memberRole,
      String memberHobby,
    ) async {
    final response = await http.post(apiPerfix+'api/customer/AddFamilyMemberInfo',body: {
      "MID": mid,
      "MemberRole":memberRole,
      "MemberHobby":memberHobby,
    });
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      //print(response.body);
      return commonResultFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}