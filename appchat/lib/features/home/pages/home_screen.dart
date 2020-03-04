import 'package:appchat/env/navigator_bar.dart';
import 'package:appchat/features/home/pages/activity.dart';
import 'package:appchat/features/home/pages/profile.dart';
import 'package:appchat/features/home/pages/search.dart';
import 'package:appchat/features/home/pages/time_line.dart';
import 'package:appchat/features/home/pages/update.dart';
import 'package:appchat/features/home/pages/word_time_line.dart';
import 'package:appchat/model/user.dart';
import 'package:appchat/service/auth.dart';
import 'package:appchat/service/feed.dart';
import 'package:appchat/service/followers.dart';
import 'package:appchat/service/following.dart';
import 'package:appchat/service/timeline.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

AuthService auth = AuthService.instance;
FeedService feed = FeedService.instance;
FollowerService follower = FollowerService.instance;
FollowingService following = FollowingService.instance;
TimelineService timeline = TimelineService.instance;
User loggedInUser;

class HomeScreen extends StatefulWidget {
  final String id;

  const HomeScreen({Key key, this.id}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController;
  int _pageIndex = 1;


  void getUser()async{
    loggedInUser = await auth.getCurrentUser();
  }

  @override
  void initState() {
    super.initState();
    getUser();
    pageController = PageController();
  }

  onChangeIndex(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: (){
          setState(() {
            _pageIndex = 1;
          });
          return;
        },
        child: PageView(
          children: <Widget>[
            WordTimeLine(),
            TimeLine(),
            Activity(),
            Update(),
            Search(),
            Profile(),
          ],
          controller: pageController,
          onPageChanged: onChangeIndex,
          //physics: NeverScrollableScrollPhysics(),
        ),
      ),

      bottomNavigationBar: CurvedNavigationBar(
        index: _pageIndex,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.language,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.home,
            size: 25,
            color: Colors.white,
          ),
          Icon(Icons.notifications, size: 25, color: Colors.white),
          Icon(Icons.camera_alt, size: 25, color: Colors.white),
          Icon(Icons.search, size: 35, color: Colors.white),
          Icon(Icons.person, size: 25, color: Colors.white),
        ],
        color: Colors.pink,
        buttonBackgroundColor: Colors.pink,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: onTap,
      ),
    );
  }
}