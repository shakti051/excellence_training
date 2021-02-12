import 'package:eklavayam/screens/home/Bottomtabs/profile/profiletab/AboutScreen.dart';
import 'package:eklavayam/screens/home/Bottomtabs/profile/profiletab/FollowingScreen.dart';
import 'package:eklavayam/screens/home/Bottomtabs/profile/profiletab/FollwerScreen.dart';
import 'package:eklavayam/screens/home/Bottomtabs/profile/profiletab/PostScreen.dart';
import 'package:eklavayam/screens/home/Bottomtabs/profile/profiletab/TimeLineScreen.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:flutter/material.dart';

class ProfileHomeScreen extends StatefulWidget {
  int userid,loggeduserid;

  ProfileHomeScreen(this.userid,this.loggeduserid);

  @override
  _ProfileHomeScreenState createState() => _ProfileHomeScreenState();
}

class _ProfileHomeScreenState extends State<ProfileHomeScreen> {

  int _currentIndex = 0;
   List<Widget> _children =[];// [TimeLineScreen(),AboutScreen(),PostScreen(),FollwerScreen(),FollowingScreen()];

  @override
  void initState() {

    super.initState();
   _children= [TimeLineScreen(widget.userid,widget.loggeduserid),AboutScreen(widget.userid,widget.loggeduserid),PostScreen(widget.userid,widget.loggeduserid),FollwerScreen(widget.userid,widget.loggeduserid),FollowingScreen(widget.userid,widget.loggeduserid)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bluecolor,
        title: Text('My Profile'),
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: orangecolor,
        unselectedItemColor: bluecolor,

        selectedLabelStyle: TextStyle(color: orangecolor,fontSize: 16),
        unselectedLabelStyle: TextStyle(color: bluecolor),
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home,),
            title: Text('TimeLine'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('About'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.post_add),
              title: Text('Post')
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            title: Text('Follwers'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person_search_outlined),
            title: Text('Folowing'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

}
