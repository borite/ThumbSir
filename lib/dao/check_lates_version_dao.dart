import 'dart:async';
import 'package:http/http.dart' as http;
import '../model/check_lates_version_model.dart';
import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class CheckLatestVersionDao {
  static Future<CheckLatestVersion> checkVersion() async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/commontools/CheckLatestVersion'
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return checkLatestVersionFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}