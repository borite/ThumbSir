import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String defaultText;
  final ValueChanged<String> onChanged;
  const Input({Key key,this.defaultText,this.onChanged});
  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState(){
    if(widget.defaultText != null){
      setState(() {
        _controller.text = widget.defaultText;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      height: 40,
      margin: EdgeInsets.only(top: 25),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: Color(0xFF2692FD)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: TextField(
        controller: _controller,
        onChanged: _onChanged,
        autofocus: false,
        style: TextStyle(
          fontSize: 14,
          color: Color(0xFF999999),
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 7),
          border: InputBorder.none,
          hintStyle: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
  _onChanged(String text){
    if(widget.onChanged != null){
      widget.onChanged(text);
    }
  }
}

