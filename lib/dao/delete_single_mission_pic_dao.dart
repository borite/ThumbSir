import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class DeleteMissionPicDao {
  static Future<CommonResult> deleteSingleMissionPic(String missID,String userID,String userLevel, picUrl) async {
    final response = await http.post(apiPerfix+'api/mission/DeleteSingleMissionPic',body: {
      "missionID": missID,
      "userID":userID,
      "userLevel":userLevel,
      "picUrls":picUrl
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