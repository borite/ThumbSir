import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String hintText;
  final String tipText;
  final String rightText;
  final String errorTipText;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final inputType;
  final RegExp reg;
  const Input({Key key,this.controller,this.onChanged,this.hintText="",this.tipText="",this.rightText="格式正确",this.errorTipText,this.inputType,this.reg});
  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  FocusNode _focusNode = FocusNode();
  bool textBool = true;// 输入的内容是否合法
  Color tipColor = Color(0xFF2692FD);
  int tip = 0;

  @override
  void initState() {
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // TextField失去焦点
        setState(() {
          textBool = this.widget.reg.hasMatch(this.widget.controller.text);
        });
        if(textBool == true){
          setState(() {
            tipColor = Color(0xFF2692FD);
          });
        }else if(textBool == false ){
          setState(() {
            tipColor = Color(0xFFF24848);
          });
        }
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    _focusNode.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            width: 335,
            height: 40,
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              controller: widget.controller,
              autofocus: false,
              keyboardType: this.widget.inputType,// TextInputType.phone
              onChanged: _onChanged,
              focusNode: _focusNode,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF999999),
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(8, 0, 10, 10),
                border: OutlineInputBorder(
                  /*边角*/
                  borderRadius: BorderRadius.all(Radius.circular(8),),
                  borderSide: BorderSide(color: tipColor, width: 1,),
                ),
                enabledBorder: OutlineInputBorder(
                  /*边角*/
                  borderRadius: BorderRadius.all(Radius.circular(8),),
                  borderSide: BorderSide(color: tipColor, width: 1,),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8),),
                  borderSide: BorderSide(color: tipColor, width: 1,),
                ),
                hintStyle: TextStyle(fontSize: 14),
                hintText: widget.hintText,
              ),
            ),
        ),
        Container(
          width: 335,
          margin: EdgeInsets.only(top: 5,left: 15),
          child: Row(
            children: <Widget>[
              Text(
                tip == 0 ? this.widget.tipText : tip == 2 ? this.widget.errorTipText:this.widget.rightText,
                style: TextStyle(
                  fontSize: 12,
                  color: tip == 0 ? Color(0xFF999999):tipColor,
                ),textAlign: TextAlign.left,),
            ],
          )
        )
      ],
    );
  }
  _onChanged(String text){
    if(widget.onChanged != null){
      widget.onChanged(text);
      setState(() {
        textBool = this.widget.reg.hasMatch(this.widget.controller.text);
      });
      if(textBool == true){
        setState(() {
          tipColor = Color(0xFF2692FD);
          tip = 1;
        });
      }else if (textBool == false){
        setState(() {
          tip = 2;
        });
      }
    }
  }
}

