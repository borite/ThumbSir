import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String hintText;
  final String tipText;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const Input({Key key,this.hintText,this.tipText,this.onChanged,this.controller});
  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            width: 335,
            height: 40,
            margin: EdgeInsets.only(top: 25),
            decoration: BoxDecoration(
              border: Border.all(width: 1,color: Color(0xFF2692FD)),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: TextField(
              controller: widget.controller,
              autofocus: false,
              onChanged: _onChanged,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF999999),
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
              ),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(8, 0, 10, 10),
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 14),
                  hintText: widget.hintText
              ),
            ),
        ),
        Container(
          width: 335,
          margin: EdgeInsets.only(top: 10),
          child: Text(widget.tipText,style: TextStyle(
            fontSize: 12,
            color: Color(0xFF999999),
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none,
          ),textAlign: TextAlign.left,),
        )
      ],
    );
  }
  _onChanged(String text){
    if(widget.onChanged != null){
      widget.onChanged(text);
    }
  }
}

