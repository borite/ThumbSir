import 'dart:async';
import 'dart:convert';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;


class CreatMissionDao {
  static Future<CommonResult> creatMission(
      String companyID,
      String userID,
      String selectTaskIDs,
      String minCount,
      String userLevel,
      List missionContent
  ) async {
    List<MissionSubmit> aaa =new List<MissionSubmit>();
    missionContent.forEach((element) {
      var i=missionSubmitFromJson(element);
      aaa.add(i);
    });
    var body ={"CompanyID": companyID,
      "userID": userID,
      "SelectTaskIDs":selectTaskIDs,
      "MinCount":minCount,
      "UserLevel":userLevel,
      "MissionContent":aaa
    } ;
    final response = await http.post(apiPerfix+'api/mission/CreatMission',
        headers: {'Content-type': 'application/json'},
        body:json.encode(body));
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return commonResultFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}

MissionSubmit missionSubmitFromJson(String str) => MissionSubmit.fromJson(json.decode(str));

String missionSubmitToJson(MissionSubmit data) => json.encode(data.toJson());

class MissionSubmit {
  MissionSubmit({
    this.id,
    this.taskTitle,
    this.taskUnit,
  });

  String id;
  String taskTitle;
  String taskUnit;

  factory MissionSubmit.fromJson(Map<String, dynamic> json) => MissionSubmit(
    id: json["ID"] == null ? null : json["ID"],
    taskTitle: json["TaskTitle"] == null ? null : json["TaskTitle"],
    taskUnit: json["TaskUnit"] == null ? null : json["TaskUnit"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id == null ? null : id,
    "TaskTitle": taskTitle == null ? null : taskTitle,
    "TaskUnit": taskUnit == null ? null : taskUnit,
  };
}