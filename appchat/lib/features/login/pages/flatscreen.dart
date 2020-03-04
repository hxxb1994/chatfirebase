import 'package:appchat/env/theme_model.dart';
import 'package:appchat/features/home/pages/home_screen.dart';
import 'package:appchat/features/login/pages/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class FlatScreen extends StatefulWidget {
  @override
  _FlatScreenState createState() => _FlatScreenState();
}

class _FlatScreenState extends State<FlatScreen> {

  void gotoLogin() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString('uid');

    if(id!=null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen(id:id)));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    }
  }

  void showDialogAlert(String txt) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(txt),
        );
      },
    );
  }



  @override
  void initState() {
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
