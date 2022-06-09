import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:new_lianghua_app/model/get_direct_sign_model.dart';

import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class GetDirectSignDao {

  //{filename:'abc.jpg',mtype:1}

  static Future<GetSignResult> httpGetSign(String fileName,String typeCode) async {
    var client = http.Client();
    final response= await client.post(
        Uri.http(apiPerFix,'/api/commontools/GetDirectUploadSign'),
        body: {
          "filename":fileName,
          "mtype":typeCode
        });
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getSignResultFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}