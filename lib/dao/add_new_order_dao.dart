import 'dart:async';
import 'package:http/http.dart' as http;

import '../model/add_new_order_model.dart';
import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class AddNewOrderDao {
  static Future<AddNewOrder> addNewOrderPost(
      String orderName,
      String unitPrice,
      String orderCount,
      String orderTotalPrice,
      String orderRemark,
      String userID,
      String buySeats,
      ) async{
    var client = http.Client();
    final response= await client.post(
        Uri.http(apiPerFix,'/api/order/AddNewOrder'),
        body: {
          "OrderName": orderName,
          "UnitPrice": unitPrice,
          "OrderCount": orderCount,
          "OrderTotalPrice": orderTotalPrice,
          "OrderRemark": orderRemark,
          "OrderUserID":userID,
          "BuySeats":buySeats,
        });
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      //print(response.body);
      return addNewOrderFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}