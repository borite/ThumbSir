import 'dart:async';
import 'package:http/http.dart' as http;
import '../model/get_leader_and_team_member_model.dart';
import '../utils/common_vars.dart';

//接口地址前缀
<<<<<<< HEAD
<<<<<<< HEAD
const String apiPerFix=Url.testApiPrefix;
=======
const String apiPerfix=CommonVars.apiPrefix;
>>>>>>> parent of e137123c (空安全前)
=======
const String apiPerfix=CommonVars.apiPrefix;
>>>>>>> parent of e137123c (空安全前)

class GetLeaderAndTeamMemberDao {
  static Future<GetLeaderAndTeamMember> getLeaderAndTeamMember(String userID) async {
    final response = await http.get(
        Uri.http(
            apiPerFix,
            '/api/contact/getLeaderAndTeamMember',
            {'userID':userID}
        )
    );
    //Utf8Decoder utf8decoder = Utf8Decoder();  // 修复中文乱码
    //var result = json.decode(utf8decoder.convert(response.bodyBytes));
    if(response.statusCode == 200){
      return getLeaderAndTeamMemberFromJson(response.body);
    }else{
      throw Exception(response.body);
    }
  }
}