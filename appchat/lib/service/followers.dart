import 'package:cloud_firestore/cloud_firestore.dart';

class FollowerService{
  static final FollowerService _instance = FollowerService._();
  static FollowerService get instance => _instance;
  FollowerService._();

  final Ref = Firestore.instance.collection('followers');

  Future<int> getFollowers() async{
      QuerySnapshot snapshot = await Ref.document()
      .collection('usersFollower')
      .getDocuments();
        
    return snapshot.documents.length;
  }
}