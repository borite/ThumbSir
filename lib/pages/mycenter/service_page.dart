import 'package:ThumbSir/dao/send_feed_back_dao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/common/reg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final TextEditingController feedBackController=TextEditingController();
  RegExp feedBackReg;
  bool feedBackBool = false;
  @override
  void initState() {
    feedBackReg = FeedBackReg;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: <Widget>[
            // 内容
            Container(
              child: ListView(
                children: <Widget>[
                  // 客服
                  Container(
                    margin:EdgeInsets.only(top: 80,left: 20,right: 20,bottom: 30),
                    width: 335,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // 头像
                        Container(
                          width: 60,
                          height: 60,
                          margin: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Colors.white,
                            boxShadow: [BoxShadow(
                                color: Color(0xFFcccccc),
                                offset: Offset(0.0, 3.0),
                                blurRadius: 10.0,
                                spreadRadius: 2.0
                            )],
                          ),
                          child:Image(
                            image: AssetImage('images/my_big.png'),
                          ),
                        ),
                        Container(
                          width: 250,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '小莹 15012345678',
                                    style:TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF666666),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  Container(width: 2,)
                                ],
                              ),
                              Container(
                                  width: 250,
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xFF93C0FB),width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        '您好，我是您的专属客服小莹，电话与微信同号，您有任何问题都可以随时联系我，小莹随时恭候哦~',
                                        style:TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                      Text(
                                        '您还可以在下方输入您的问题或对拇指先生APP的意见和建议，收到后我会尽快给您答复哒~',
                                        style:TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30,top: 40),
                    child: Text('请输入您的问题、意见或建议：',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),),
                  ),
                  // 输入框
                  Container(
                    height: 100,
                    margin: EdgeInsets.only(top: 15,left: 30,right: 30,bottom: 50),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Color(0xFF5580EB)),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: feedBackController,
                      autofocus: false,
                      keyboardType: TextInputType.multiline,
                      onChanged: _onChanged,
                      maxLines: null,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF999999),
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none,
                      ),
                    ),
                  ),
                  // 确定
                  GestureDetector(
                    onTap: ()async{
                      if(feedBackBool == true){
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        final userId= prefs.getString("userID");
                        var result = await SendFeedBackDao.sendFeedBack(userId, feedBackController.text);
                        if(result.code == 200){
                          _onSuccessAlertPressed(context);
                          setState(() {
                            feedBackController.text = '';
                            feedBackBool = false;
                          });
                        }else{
                          _onErrorAlertPressed(context);
                          setState(() {
                            feedBackController.text = '';
                            feedBackBool = false;
                          });
                        };
                      }else{}
                    },
                    child: Container(
                      height:40,
                      padding: EdgeInsets.only(top: 10),
                      margin: EdgeInsets.only(left: 80,right: 80),
                      decoration: feedBackBool == false ?
                      BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color:Color(0xFF93C0FB),
                      )
                          :
                      BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color:Color(0xFF5580EB),
                      ),
                      child: Text('确定',style:TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),textAlign: TextAlign.center,),
                    ),
                  )
                ],
              ),
            ),
            // 顶部导航区域
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFF5580EB),
                image: DecorationImage(
                  image:AssetImage('images/circle.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child:Container(
                height: 80,
                padding: EdgeInsets.only(top: 30),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 15),
                        child: Image(image: AssetImage('images/back_w_arrow.png'),),
                      ),
                    ),
                    Text(
                      '客服中心',
                      style:TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Container(
                      width: 50,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  _onChanged(String text){
    if(text != null){
      setState(() {
        feedBackBool = feedBackReg.hasMatch(feedBackController.text);
      });
    }
  }
  _onSuccessAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "提交成功",
      desc: "感谢您对拇指先生的支持！",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }
  _onErrorAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "提交失败",
      desc: "请检查您的网络情况",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }
}
