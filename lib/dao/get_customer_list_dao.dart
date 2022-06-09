import 'dart:async';
import 'package:ThumbSir/model/get_customer_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.testApiPrefix;

class GetCustomerListDao {
  static Future<GetCustomerList> getCustomerList(
      String ageMin,
      String ageMax,
      String birthMonth,
      String userID,
      String mainNeed,
      String userType,
      String pageIndex,
      String pageSize
    ) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/customerfrom/GetCustomerList',
            {'ageMin':ageMin,'ageMax':ageMax,'birthMonth':birthMonth,'userID':userID,'mainNeed':mainNeed,'UserType':userType,'pageIndex':pageIndex,'pageSize':pageSize}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getCustomerListFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}