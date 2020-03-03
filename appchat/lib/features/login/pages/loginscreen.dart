import 'package:appchat/env/theme_model.dart';
import 'package:appchat/features/home/home_screen.dart';
import 'package:appchat/features/login/blocs/button_facebook.dart';
import 'package:appchat/features/login/blocs/button_google.dart';
import 'package:appchat/features/login/blocs/button_login.dart';
import 'package:appchat/features/login/pages/registerscreen.dart';
import 'package:appchat/features/login/service/auth.dart';
import 'package:appchat/features/login/widgets/input_login.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  bool _showSpinner = false;

  void _gotoRegisterScreen(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
  }

  void showDialogAlert(String txt){
    showDialog(
      context: context,
      builder: (context) =>
        AlertDialog(
          content: Text(txt),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeModel theme = Injector.get(context: context);
    return Scaffold(
      backgroundColor: theme.background,
      body: SafeArea(
        top: true,
        child: ModalProgressHUD(
          inAsyncCall: _showSpinner,
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 30,right: 30,bottom: 10, top: 40),
                    child: Center(
                        child: Image.asset('assets/images/logo.png', fit: BoxFit.fill,),
                    ),
                  ),
                  Text(
                    'Welcome back',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: 'Montserrat',
                      color: theme.primaryColor
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
                    hintText: 'Email address',
                    controller: _emailController,
                    icon: Icons.perm_identity,
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InputLogin(
                    hintText: 'Password',
                    icon: Icons.lock_open,
                    controller: _passController,
                    inputType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                    child: Text(
                      'Forgot Password?',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: theme.primaryColor),
                    ),
                  ),
                  GestureDetector(
                    onTap: _signIn,
                    child: ButtonLogin(text: 'LOG IN'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Or connect using',
                    style: TextStyle(color: theme.primaryColor),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 50,right: 50, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ButtonFacebook(),
                        ButtonGoogle(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            'Don\'t have an account? ',
                            style: TextStyle(color: theme.primaryColor),
                        ),
                        GestureDetector(
                          onTap: (){_gotoRegisterScreen();},
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,)
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
            print("cant change brightness");
          } else {
            theme.changeBrightness();
          }
        },
        icon: Icon(Icons.refresh),
        label: Text("Change theme"),
      ),
    );
  }

  _signIn() async {

    String email = _emailController.text;
    String pass = _passController.text;

    if(email==''|| pass ==''){
      showDialogAlert("Fill text!");
      return;
    }
    setState(() {
      _showSpinner = true;
    });

    dynamic result = await AuthService.instance.signInEmail(_emailController.text, _passController.text);
print(result);
    if(result != null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }else{
      showDialogAlert("Login Fail!");
    }

    setState(() {
      _showSpinner = false;
    });
  }
}
