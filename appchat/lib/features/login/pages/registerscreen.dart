import 'package:appchat/env/theme_model.dart';
import 'package:appchat/features/login/blocs/button_login.dart';
import 'package:appchat/features/login/pages/loginscreen.dart';
import 'package:appchat/features/login/widgets/input_login.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    final ThemeModel theme = Injector.get(context: context);
    return WillPopScope(
      onWillPop: (){
        return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));;
      },
      child: Scaffold(
        backgroundColor: theme.background,
        body: SafeArea(
          top: true,
          child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, top:  10, bottom: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              'Let\'s Get Started',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 25,
                                  fontFamily: 'Montserrat',
                                  color: theme.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Log in to your exstant account of hxb',
                            style: TextStyle(color: theme.primaryColor),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          InputLogin(
                            hintText: 'Email',
                            controller: _emailController,
                            icon: Icons.email,
                            inputType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InputLogin(
                            hintText: 'Password',
                            controller: _passController,
                            icon: Icons.lock_open,
                            inputType: TextInputType.visiblePassword,
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InputLogin(
                            hintText: 'Comfirm Password',
                            controller: _confirmPassController,
                            icon: Icons.lock_open,
                            obscureText: true,
                            inputType: TextInputType.visiblePassword,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: (){},
                            child: ButtonLogin(
                              text: 'CREATE',
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                    'Already have an account? ',
                                    style: TextStyle(color: theme.primaryColor),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                  },
                                  child: Text(
                                    'Login here',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDialogAlert(String txt){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
         content: Text(txt),
        )
    );
  }
}
