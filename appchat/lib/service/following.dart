import 'package:cloud_firestore/cloud_firestore.dart';

class FollowingService{
  static final FollowingService _instance = FollowingService._();
  static FollowingService get instance => _instance;
  FollowingService._();

  final activityFeedRef = Firestore.instance.collection('following');
}