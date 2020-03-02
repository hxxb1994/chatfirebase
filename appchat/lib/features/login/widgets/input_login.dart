import 'package:flutter/material.dart';

class InputLogin extends StatefulWidget {
  const InputLogin({
    Key key,
    this.icon,
    this.hintText,
    this.inputType,
    this.obscureText = false,
    this.controller,
  }): super(key:key);

  final IconData icon;
  final String hintText;
  final TextInputType inputType;
  final bool obscureText;
  final TextEditingController controller;

  @override
  _InputLoginState createState() => _InputLoginState();
}

class _InputLoginState extends State<InputLogin> {

  Color _colorFocus = Colors.blue;
  Color _colorText = Colors.black54;

  final FocusNode _focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: _focus,
        style: TextStyle(
            color: (_focus.hasFocus)? _colorFocus : _colorText,
            fontFamily: "Montserrat",
            fontSize: 16.0
        ),
        keyboardType: widget.inputType,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          prefixIcon: Icon(
            widget.icon,
            color: (_focus.hasFocus)? _colorFocus : _colorText,
            size: 22.0,
          ),
//          suffixIcon: ,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 16.0,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
