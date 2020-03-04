import 'dart:io';

import 'package:appchat/env/theme_model.dart';
import 'package:appchat/features/home/home_screen.dart';
import 'package:appchat/features/login/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path_provider/path_provider.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as Im;

class FirstTimeScreen extends StatefulWidget {
  @override
  _FirstTimeScreenState createState() => _FirstTimeScreenState();
}

class _FirstTimeScreenState extends State<FirstTimeScreen> {

  bool _showSpinner = false;
  int _currentStep = 0;

  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();

  //post
  String _profileId = Uuid().v4();
  String _fullname;
  File _image;
  int _dDateYear;
  
  int _radioSelect;
  String _genderValue = 'Male';
  String _username;
  String _bio;

  @override
  void initState() {
    super.initState();
    _radioSelect = 0;
  }

  _handleRadioValueChange(int value){
    setState(() {
      _radioSelect = value;
      switch(value){
        case 0: {
          _genderValue = 'Male';
          break;
        }
        case 1: {
          _genderValue = 'Female';
          break;
        }
        case 2: {
          _genderValue = 'LGBTQ';
          break;
        }
      }
    });
  }

  String _date;
  
  
  void showAlertDialog(String txt){
    showDialog(
        context: context,
      builder: (context) => AlertDialog(
        content: Text(txt),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeModel theme = Injector.get(context: context);
    return Scaffold(
      backgroundColor: theme.background,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Text(
              'Set up account',
              style: TextStyle(
                fontSize: 35,
                fontFamily: 'Pacifico',
                color: theme.accentColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: Theme(
                data: ThemeData(
                  primaryColor: theme.accentColor, 
                ),
                child: Stepper(
                  controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue, VoidCallback onStepCancel })
                  => Row(
                    mainAxisAlignment: (this._currentStep > 0) ? MainAxisAlignment.spaceAround : MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: onStepContinue,
                        color: theme.accentColor,
                        child: Text(
                          (this._currentStep<2)?'Continue':'Complete',
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontFamily: 'Pacifico',
                          ),
                        ),
                      ),
                      (this._currentStep > 0) ?
                      FlatButton(
                        onPressed: onStepCancel,
                        color: theme.accentColor,
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontFamily: 'Pacifico',
                          ),
                        ),
                      ): SizedBox(),
                    ],
                  ),
                  currentStep: this._currentStep,
                  steps: _signUpStep(theme),
                  onStepTapped: (step){
                    setState(() {
                      _currentStep = step;
                    });
                  },
                  onStepCancel: (){
                    setState(() {
                      _currentStep -= 1;
                    });
                  },
                  onStepContinue: (){
                    if(_currentStep == _signUpStep(theme).length - 1){
                      //create profile
                      _updateProfile();
                    }else{
                      setState(() {
                        _currentStep += 1;
                      });
                    }
                  },
                ),
              ),
            ),
          ],
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

  List<Step> _signUpStep(ThemeModel theme){
    return [
      Step(
        title: Text(
          'Profile Picture',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 25,
            color: theme.accentColor,
          ),
        ),
        content: _circlePicture(),
        isActive: _currentStep > 0,
      ),
      Step(
        title: Text(
          'Information',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 25,
            color: theme.accentColor,
          ),
        ),
        content: _informationSetup(theme),
        isActive: _currentStep > 1,
      ),
      Step(
        title: Text(
          'Complete',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 25,
            color: theme.accentColor,
          ),
        ),
        content: Padding(
          padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
          child: Theme(
            data: ThemeData(
              accentColor: theme.accentColor,
              primaryColor: theme.primaryColor,
            ),
            child: TextField(
              controller: _bioController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: new BorderSide(
                    color: theme.primaryColor,
                  )
                ),
                hintText: 'Add your bio',
                hintStyle: TextStyle(
                  color: theme.primaryColor,
                )
              ),
            ),
          ),
        ),
        isActive: _currentStep > 2,
      ),
    ];
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

 compressImage() async {
   final tempDir = await getTemporaryDirectory();
   final path = tempDir.path;
   Im.Image imageFile = Im.decodeImage(_image.readAsBytesSync());
   final compressImageFile = File('$path/img_$_profileId.jpg')
     ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));

   setState(() {
     _image = compressImageFile;
   });
 }

  Widget _circlePicture() => Container(
    child: Stack(
      children: <Widget>[
        Center(
          child: GestureDetector(
            onTap: (){
              if(this._image == null){
                getImage();
              }
            },
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(100),
              ),
              child: ClipOval(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: (_image != null) ?
                  Image.file(_image, fit: BoxFit.fitHeight,)
                      : Text('+', style: TextStyle(fontSize: 50),),
                ),
              ),
            ),
          ),
        ),
        (this._image == null)?SizedBox():Padding(
          padding: const EdgeInsets.only(left: 170, top: 150),
          child: FlatButton(
            onPressed: (){
              getImage();
            },
            child: Text('+', style: TextStyle(color: Colors.white, fontSize: 30),),
            shape: CircleBorder(),
            color: Colors.pink[400],
            padding: EdgeInsets.all(1.0),
          ),
        )
      ],
    ),
  );

  Widget _informationSetup(ThemeModel theme) => Container(
    child: Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
          child: TextField(
            controller: _fullnameController,
            decoration: InputDecoration(
              labelText: 'Full name',
              labelStyle: TextStyle(color: theme.primaryColor),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80.0, left: 20, right: 20),
          child: TextField(
            controller: _usernameController,
            cursorColor: Colors.white,
            decoration: InputDecoration(
                labelText: 'Address',
                labelStyle: TextStyle(color: theme.primaryColor),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 150.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Radio(
                activeColor: theme.accentColor,
                value: 0,
                groupValue: _radioSelect,
                onChanged: _handleRadioValueChange,
              ),
              Text('Male', style: TextStyle(
                fontSize: 12.0,
                color: theme.accentColor,
              ),),
              Radio(
                activeColor: theme.accentColor,
                value: 1,
                groupValue: _radioSelect,
                onChanged: _handleRadioValueChange,
              ),
              Text('Female', style: TextStyle(
                fontSize: 12.0,
                color: theme.accentColor,
              ),),
              Radio(
                activeColor: theme.accentColor,
                value: 2,
                groupValue: _radioSelect,
                onChanged: _handleRadioValueChange,
              ),
              Text('LGBTQ', style: TextStyle(
                fontSize: 12.0,
                color: theme.accentColor,
              ),),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 200.0, left: 20.0, right: 20.0, bottom: 10.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 4.0,
            onPressed: () {
              DatePicker.showDatePicker(context,
                  theme: DatePickerTheme(
                    doneStyle: TextStyle(
                        color: Colors.pink,
                        fontFamily: 'Montseratt',
                        fontSize: 18.0),
                    cancelStyle: TextStyle(
                        color: Colors.pink,
                        fontFamily: 'Montseratt',
                        fontSize: 18.0),
                    itemHeight: 60.0,
                    containerHeight: 300.0,
                  ),
                  showTitleActions: true,
                  minTime: DateTime(1950, 1, 1),
                  maxTime: DateTime(2019, 12, 31), onConfirm: (date) {
                    print('confirm $date');
                    _date = '${date.year} - ${date.month} - ${date.day}';
                    _dDateYear = date.year;
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
            },
            child: Container(
              alignment: Alignment.center,
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.date_range,
                              size: 18.0,
                              color: theme.accentColor,
                            ),
                            Text(
                              " $_date",
                              style: TextStyle(
                                  color: theme.accentColor,
                                  fontFamily: 'Montseratt',
                                  fontSize: 14.0),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Text(
                    "  Change",
                    style: TextStyle(
                        color: theme.accentColor,
                        fontFamily: 'Montseratt',
                        fontSize: 18.0),
                  ),
                ],
              ),
            ),
            color: theme.primaryColor,
          ),
        ),
      ],
    ),
  );

  _updateProfile() async{

    setState(() {
      _showSpinner = true;
    });

    final dateNow = DateTime.now().year;
    final ageN = dateNow - _dDateYear;
    _fullname = _fullnameController.text;
    _username = _usernameController.text;
    _bio = _bioController.text;
    

    bool result = await AuthService.instance.createUser(ageN, _bio, _date, 
    _genderValue, _fullname, _profileId, _image, _username);

    setState(() {
      _showSpinner = false;
    });    
    if(result){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
    }else{
      showAlertDialog('Update profile fail!');
    }
  }
}
