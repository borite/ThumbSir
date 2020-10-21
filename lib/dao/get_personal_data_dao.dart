import 'dart:async';
import 'package:ThumbSir/model/get_personal_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class GetPersonalDataDao {
  static Future<GetPersonalData> getPersonalData(
      String userId,
      String companyId,
      String startTime,
      String endTime,
  ) async {
    final response = await http.get(apiPerfix+'api/analysis/GetPersonalData?userID='+userId+'&companyID='+companyId+'&startTime='+startTime+'&endTime='+endTime);
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getPersonalDataFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}