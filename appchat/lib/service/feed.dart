import 'package:cloud_firestore/cloud_firestore.dart';

class FeedService{
  static final FeedService _instance = FeedService._();
  static FeedService get instance => _instance;
  FeedService._();

  final activityFeedRef = Firestore.instance.collection('feed');
}