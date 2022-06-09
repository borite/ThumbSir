import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

onLoadAlert(context) {
  Alert(
    context: context,
    title: "加载失败",
    desc: "请检查网络连接情况",
    buttons: [
      DialogButton(
        child: Text(
          "确定",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        color: Color(0xFF5580EB),
      )
    ],
  ).show();
}