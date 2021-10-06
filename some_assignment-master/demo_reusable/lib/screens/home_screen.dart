import 'package:demo_reusable/components/appbar.dart';
import 'package:demo_reusable/screens/settings_screen.dart';
import 'package:demo_reusable/utils/appsettings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IAppBar(
        color: context.watch<AppSettings>().appColor,
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    'HOME',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 0),
                  child: IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SettingsScreen();
                      }));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        color: context.watch<AppSettings>().appColor,
      ),
    );
  }
}
