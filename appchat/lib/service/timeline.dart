import 'package:cloud_firestore/cloud_firestore.dart';

class TimelineService{
  static final TimelineService _instance = TimelineService._();
  static TimelineService get instance => _instance;
  TimelineService._();

  final activityFeedRef = Firestore.instance.collection('timeline');
}