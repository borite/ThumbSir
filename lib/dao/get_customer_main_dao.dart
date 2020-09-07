import 'dart:async';
import 'package:ThumbSir/model/get_customer_main_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class GetCustomerMainDao {
  static Future<GetCustomerMain> getCustomerMain(String userID,String userType,String pageIndex,String pageSize) async {
    final response = await http.get(
        apiPerfix+'api/customer/GetCustomerMain?userID='+userID+'&UserType='+userType+'&pageIndex='+pageIndex+'&pageSize='+pageSize);
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getCustomerMainFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}