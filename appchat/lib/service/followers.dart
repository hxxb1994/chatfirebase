import 'package:cloud_firestore/cloud_firestore.dart';

class FollowerService{
  static final FollowerService _instance = FollowerService._();
  static FollowerService get instance => _instance;
  FollowerService._();

  final activityFeedRef = Firestore.instance.collection('followers');
}