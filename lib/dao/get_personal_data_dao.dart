import 'dart:async';
import 'package:http/http.dart' as http;

import '../model/get_personal_data_model.dart';
import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class GetPersonalDataDao {
  static Future<GetPersonalData> getPersonalData(
      String userId,
      String companyId,
      String startTime,
      String endTime,
  ) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/analysis/GetPersonalData',
            {'userID':userId,'companyID':companyId,'startTime':startTime,'endTime':endTime}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getPersonalDataFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}