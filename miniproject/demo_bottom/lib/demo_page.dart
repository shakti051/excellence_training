import 'package:demo_bottom/home_page.dart';
import 'package:demo_bottom/inbox_screen.dart';
import 'package:flutter/material.dart';

class HomePageDemo extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageDemo> {
  int selectedPage = 0;

  final _pageOptions = [
    HomeScreen(),
    InboxScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: _pageOptions[selectedPage],
        
        bottomNavigationBar: BottomNavigationBar(  
          items: [
            BottomNavigationBarItem( icon: Icon(Icons.home, size: 30), title: Text('Home'),),
            BottomNavigationBarItem(icon: Icon(Icons.mail, size: 30), title: Text('Inbox')),
 //           BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 30), title: Text('Account')),
          ],
          selectedItemColor: Colors.green,
          elevation: 5.0,
          unselectedItemColor: Colors.green[900],
          currentIndex: selectedPage,
          backgroundColor: Colors.white,
          onTap: (index){
            setState(() {
              selectedPage = index;
            });
          },
        )
    );
  }
}