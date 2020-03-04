import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{
  static final AuthService _instance = AuthService._();
  static AuthService get instance => _instance;
  AuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userRef = Firestore.instance.collection('users');
  final StorageReference storageRef = FirebaseStorage.instance.ref();


  // Stream<User> get user{
  //   return _auth.onAuthStateChanged.map((_) => User.fromFirebaseUser(_));
  // }

  // Stream<User> get user{
  //   return _auth.onAuthStateChanged.map()
  // }

  //sign email pass
  Future<String> signInEmail(String email, String password) async{
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      FirebaseUser willLoggedInUser = await _auth.currentUser();
      String userid = willLoggedInUser.uid;
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (user != null) {
        prefs.setString("email", email);
        prefs.setString("uid", userid);
        prefs.setString("password", password);

        await userRef.document(userid).get().then((doc) {
          if (doc.exists) {
            if (doc["age"] == "" ||
                doc["bio"] == "" ||
                doc["birthdate"] ==  "" ||
                doc["gender"] == "" ||
                doc["name"] == "" ||
                doc["profpic"] == "" ||
                doc["userid"] == "" ||
                doc["username"] == "") {
                  userid = 'goto';
                }
          } else {
            print("No document $userid");
            userid = null;
          }
        });
      }
      return userid;
    }catch(e) {
      print("firebase login email: "+ e.toString());
      return null;
    }
  }


  Future registerEmail(String email, String password)async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (result == null){
        return false;
      }
      FirebaseUser firebaseUser = await _auth.currentUser();
      String id = firebaseUser.uid;
      await userRef.document(id).setData({
            'age': "",
            'bio': "",
            'birtdate': "",
            'gender': "",
            'name': "",
            'profpic': "",
            'userid': "",
            'username': ""
          });
      return true;
    }catch(e){
      print("register fail: "+e.toString());
      return false;
    }
  }

  Future<String> uploadImage(imageFile, String profpic) async {
    StorageUploadTask uploadTask =
        storageRef.child("profile_$profpic.jpg").putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }


  Future createUser(int age, String bio, 
    String birtdate, String gender, String name, 
    String profileId, File imageFile, String username) async{
    try{

      String profpic = '';
      if(imageFile != null){
        profpic = await uploadImage(imageFile, profileId);
      }

      FirebaseUser firebaseUser = await _auth.currentUser();
      String id = firebaseUser.uid;
      await userRef.document(id).setData({
        'age': age,
        'bio': bio,
        'birtdate': birtdate,
        'gender': gender,
        'name': name,
        'profpic': profpic,
        'userid': id,
        'username': username
      });
      return true;
    }catch(e){
      print("create user error: "+ e.toString());
      return false;
    }
  }

}