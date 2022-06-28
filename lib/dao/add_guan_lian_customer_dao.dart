import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class AddGuanLianCustomerDao {
  static Future<CommonResult> addGuanLianCustomerPost(
      String houseID,
      String customerID,
      String description,
      String selectedMissionID,
      String missionName,
      ) async {
    var client = http.Client();
    final response= await client.post(
        Uri.http(apiPerFix,'/api/houseresource/AddGuanLianCustomer'),
        body: {
          "HouseID": houseID,
          "CustomerID": customerID,
          "Description": description,
          "SelectedMissionID": selectedMissionID,
          "MissionName":missionName,
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