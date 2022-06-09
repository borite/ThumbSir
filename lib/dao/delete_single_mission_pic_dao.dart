import 'dart:async';
import 'package:http/http.dart' as http;
import '../model/common_result_model.dart';
import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class DeleteMissionPicDao {
  static Future<CommonResult> deleteSingleMissionPic(String missID,String userID,String userLevel, picUrl) async {
    var client = http.Client();
    final response= await client.post(
        Uri.http(apiPerFix,'/api/mission/DeleteSingleMissionPic'),
        body: {
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