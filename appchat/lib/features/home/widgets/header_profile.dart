import 'package:appchat/features/home/pages/home_screen.dart';
import 'package:appchat/features/home/widgets/progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class HeaderProfile extends StatefulWidget {
  final String profileId;

  const HeaderProfile({Key key, this.profileId}) : super(key: key);

  @override
  _HeaderProfileState createState() => _HeaderProfileState();
}

class _HeaderProfileState extends State<HeaderProfile> {
  double _scale = 1.0;
  int followerCount = 0;
  int followingCount = 0;


  @override
  void initState() {
    super.initState();
    follower.getFollowers().then((value){
      setState(() {
        print('load count fllowe'+ value.toString());
        followerCount = value;
      });
    });

    following.getFollowers().then((value){
      setState(() {
        followingCount = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
    future: auth.getProflie(widget.profileId),
    builder: (context,snapshot){
      if(!snapshot.hasData){
          return circularProgress();
      }
      return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Transform(
                transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            Row(children: <Widget>[
              CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.pink,
                backgroundImage: CachedNetworkImageProvider(snapshot.data['profpic']),
              ),
              Expanded(
                flex:1,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildCountColumn("followers",followerCount),
                        buildCountColumn("following",followingCount),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                          // buildProfileButton()
                      ],
                    )
                  ],
                ),
                
              )
            ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top:12.0),
              child: Text(snapshot.data['username'],
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat'
              ),
              ),
            ),
             Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top:4.0),
              child: Text(snapshot.data['name'],
              style: TextStyle(
               
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat'
              ),
              ),
            ),
             Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top:2.0),
              child: Text(snapshot.data['bio'],
              style: TextStyle(
               
                fontFamily: 'Montserrat'
              ),
              ),
            )
         ],
        ),
      );
    },
  );
  }

  Column buildCountColumn(String label, int count){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          count.toString(),
          style: TextStyle(
            fontSize:22.0,
            fontFamily: 'Montserrat',
          ),
        ),
        Container(
          margin: EdgeInsets.only(top:4.0),
          child: Text(
            label,
            style: TextStyle(
              color:Colors.grey,
              fontFamily: 'Montserrat',
              fontSize: 15,
            ),
          ),
        )
      ],
    );
  }
}