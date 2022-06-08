import 'dart:async';
import 'package:ThumbSir/model/get_care_action_model.dart';
import 'package:ThumbSir/model/get_house_list_model.dart';
import 'package:ThumbSir/model/get_leader_model.dart';
import 'package:ThumbSir/model/section_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.testApiPrefix;

class GetHouseListDao {
  static Future<GetHouseList> httpGetHouseList(String companyId,String pageIndex,String pageSize) async {
    final response = await http.get(apiPerfix+'api/houseresource/GetHouseList?companyID='+companyId+'&pageIndex='+pageIndex+'&pageSize='+pageSize);
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getHouseListFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}