import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class SetMissionMiniNumberDao {
  static Future<CommonResult> setMiniTaskCount(String userlevel,List<MiniNumber> mincount) async {

//    List<MiniNumber> aaa =new List<MiniNumber>();
//    mincount.forEach((element) {
//      var i=miniNumberFromJson(element);
//      aaa.add(i);
//    });

    var body ={
      "UserLevel":userlevel,
      "MinCount":mincount
    };

    final response = await http.post(apiPerfix+'api/mission/SettingMissionCount',
        headers: {'Content-type': 'application/json'},
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
    this.taskId,
    this.missionCount,
  });

  int taskId;
  int missionCount;

  factory MiniNumber.fromJson(Map<String, dynamic> json) => MiniNumber(
    taskId: json["TaskID"] == null ? null : json["TaskID"],
    missionCount: json["MissionCount"] == null ? null : json["MissionCount"],
  );

  Map<String, dynamic> toJson() => {
    "TaskID": taskId == null ? null : taskId,
    "MissionCount": missionCount == null ? null : missionCount,
  };
}