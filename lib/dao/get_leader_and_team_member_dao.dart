import 'dart:async';
import 'package:ThumbSir/model/get_leader_and_team_member_model.dart';
import 'package:http/http.dart' as http;
import 'package:ThumbSir/utils/common_vars.dart';

//接口地址前缀
const String apiPerfix=CommonVars.apiPrefix;

class GetLeaderAndTeamMemberDao {
  static Future<GetLeaderAndTeamMember> getLeaderAndTeamMember(String userID) async {
    final response = await http.get(apiPerfix+'api/contact/getLeaderAndTeamMember?userID='+userID);
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getLeaderAndTeamMemberFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}