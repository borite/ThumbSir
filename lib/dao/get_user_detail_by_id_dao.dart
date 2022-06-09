import 'dart:async';
import 'package:ThumbSir/model/get_customer_info_model.dart';
import 'package:ThumbSir/model/get_user_detail_by_id_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.testApiPrefix;

class GetUserDetailBByIDDao {
  static Future<GetUserDetailById> getUserDetailBByID(
      String id
    ) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/customerfrom/GetUserDetailByID',
            {'cid':id}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getUserDetailByIdFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}