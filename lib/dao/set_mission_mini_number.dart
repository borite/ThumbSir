import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/common_result_model.dart';
import '../utils/common_vars.dart';

//接口地址前缀
const String apiPerFix=Url.apiPrefix;

class SetMissionMiniNumberDao {
  static Future<CommonResult> setMiniTaskCount(String userlevel,List<MiniNumber> mincount) async {

    var body ={
      "UserLevel":userlevel,
      "MinCount":mincount
    };
    var client = http.Client();
    final response= await client.post(
        Uri.http(apiPerFix,'/api/mission/SettingMissionCount'),
        body:json.encode(body));
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

MiniNumber miniNumberFromJson(String str) => MiniNumber.fromJson(json.decode(str));

String miniNumberToJson(MiniNumber data) => json.encode(data.toJson());

class MiniNumber {
  MiniNumber({
    required this.taskId,
    required this.missionCount,
  });

  int taskId;
  int missionCount;

  factory MiniNumber.fromJson(Map<String, dynamic> json) => MiniNumber(
    taskId: json["TaskID"],
    missionCount: json["MissionCount"],
  );

  Map<String, dynamic> toJson() => {
    "TaskID": taskId,
    "MissionCount": missionCount,
  };
}