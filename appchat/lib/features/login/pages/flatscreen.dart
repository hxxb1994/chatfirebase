import 'package:appchat/env/theme_model.dart';
import 'package:appchat/features/login/pages/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class FlatScreen extends StatefulWidget {
  @override
  _FlatScreenState createState() => _FlatScreenState();
}

class _FlatScreenState extends State<FlatScreen> {

  void gotoLogin(){
    Future.delayed(
      Duration(seconds: 2),
      (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
      }
    );
  }

  void showDialogAlert(String txt) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Retrieve the text the that user has entered by using the
          // TextEditingController.
          content: Text(txt),
        );
      },
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gotoLogin();
 }

  @override
  Widget build(BuildContext context) {
    final ThemeModel them = Injector.get(context: context);
    return Container(
      color: them.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              'SHOP F',
              style: TextStyle(
                color: Colors.pink,
                fontSize: 35,
                fontFamily: 'Pacifico'
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              'a hxb',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }
}
