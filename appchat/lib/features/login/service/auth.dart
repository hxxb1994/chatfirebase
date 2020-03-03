import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{
  static final AuthService _instance = AuthService._();
  static AuthService get instance => _instance;
  AuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userRef = Firestore.instance.collection('users');


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
                  return 'goto';
                }else{
                  return userid;
                }
          } else {
            print("No document $userid");
            return null;
          }
        });
      }
      return null;
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
      print(id);
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
}