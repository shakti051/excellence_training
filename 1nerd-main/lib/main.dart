import 'package:feedback/resources/app_colors.dart';
import 'package:feedback/screens/account/account.dart';
import 'package:feedback/screens/clients/clients.dart';
import 'package:feedback/screens/rentals/rentals.dart';
import 'package:feedback/screens/sales/sales.dart';
import 'package:feedback/widgets/account_widgets/responsive_account.dart';
import 'package:feedback/widgets/rentals/rentals.dart';
import 'package:feedback/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:feedback/screens/feedback.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: MenuPage(),
      initialRoute: '/',
      routes: {
        '/': (context) => (MediaQuery.of(context).size.width < 850 ||
                MediaQuery.of(context).size.height < 600)
            ? MobileMenuPage()
            : MenuPage(),
        '/account': (context) => (MediaQuery.of(context).size.width < 850 ||
                MediaQuery.of(context).size.height < 600)
            ? ResponsiveAccount()
            : AccountPage(),
        '/sales': (context) => SalesPage(),
        '/rentals': (context) => MediaQuery.of(context).size.width < 1050
            ? ResponsiveBilling()
            : RentalsPage(),
        '/clients': (context) => ClientsPage(),
      },
    );
  }
}

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: AppColors.BACKGROUND_COLOR,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(8, 8, 16, 16),
                      child: Text(
                        '1NERD',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Passion',
                          fontStyle: FontStyle.italic,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 200,
                      child: ListTile(
                        leading: Icon(Icons.apps, color: Colors.white),
                        title: MediaQuery.of(context).size.width < 500
                            ? Text('')
                            : Text(
                                'Account',
                                style: TextStyle(color: Colors.white),
                              ),
                        onTap: () {
                          Navigator.pushNamed(context, '/account');
                        },
                      ),
                    ),
                    Container(
                      width: 200,
                      child: ListTile(
                        leading: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        title: MediaQuery.of(context).size.width < 500
                            ? Text('')
                            : Text(
                                'Sales',
                                style: TextStyle(color: Colors.white),
                              ),
                        onTap: () {
                          Navigator.pushNamed(context, '/sales');
                        },
                      ),
                    ),
                    Container(
                      width: 200,
                      child: ListTile(
                        leading: Icon(Icons.location_city, color: Colors.white),
                        title: MediaQuery.of(context).size.width < 500
                            ? Text('')
                            : Text(
                                'Rentals',
                                style: TextStyle(color: Colors.white),
                              ),
                        onTap: () {
                          Navigator.pushNamed(context, '/rentals');
                        },
                      ),
                    ),
                    Container(
                      width: 200,
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        title: MediaQuery.of(context).size.width < 500
                            ? Text('')
                            : Text(
                                'Clients',
                                style: TextStyle(color: Colors.white),
                              ),
                        onTap: () {
                          Navigator.pushNamed(context, '/clients');
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 350,
                    ),
                    Container(
                      width: 200,
                      child: ListTile(
                        leading: Icon(Icons.account_circle, color: Colors.grey),
                        title: MediaQuery.of(context).size.width < 500
                            ? Text('')
                            : Text(
                                'Mike',
                                style: TextStyle(color: Colors.grey),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //write code for feedback here
            Expanded(flex: 8, child: Container(child: Clientfeedback())),
          ],
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: AppColors.BACKGROUND_COLOR,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(8, 8, 16, 16),
              child: Text(
                '1NERD',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'Passion',
                    fontStyle: FontStyle.italic,
                    letterSpacing: 1),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              child: ListTile(
                leading: Icon(Icons.apps, color: Colors.white),
                title: MediaQuery.of(context).size.width < 500
                    ? Text('')
                    : Text(
                        'Account',
                        style: TextStyle(color: Colors.white),
                      ),
                onTap: () {
                  Navigator.pushNamed(context, '/account');
                },
              ),
            ),
            Container(
              width: 200,
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: MediaQuery.of(context).size.width < 500
                    ? Text('')
                    : Text(
                        'Sales',
                        style: TextStyle(color: Colors.white),
                      ),
                onTap: () {
                  Navigator.pushNamed(context, '/sales');
                },
              ),
            ),
            Container(
              width: 200,
              child: ListTile(
                leading: Icon(Icons.location_city, color: Colors.white),
                title: MediaQuery.of(context).size.width < 500
                    ? Text('')
                    : Text(
                        'Rentals',
                        style: TextStyle(color: Colors.white),
                      ),
                onTap: () {
                  Navigator.pushNamed(context, '/rentals');
                },
              ),
            ),
            Container(
              width: 200,
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.white),
                title: MediaQuery.of(context).size.width < 500
                    ? Text('')
                    : Text(
                        'Clients',
                        style: TextStyle(color: Colors.white),
                      ),
                onTap: () {
                  Navigator.pushNamed(context, '/clients');
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 350,
            ),
            Container(
              width: 200,
              child: ListTile(
                leading: Icon(Icons.account_circle, color: Colors.grey),
                title: MediaQuery.of(context).size.width < 500
                    ? Text('')
                    : Text(
                        'Mike',
                        style: TextStyle(color: Colors.grey),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MobileMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: AppColors.BACKGROUND_COLOR,
              margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
              padding: EdgeInsets.only(bottom: 8),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: Text(
                      '1NERD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'Passion',
                        fontStyle: FontStyle.italic,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () => Navigator.pushNamed(context, '/account'),
                          child: Icon(Icons.apps, color: Colors.white)),
                      InkWell(child: Icon(Icons.home, color: Colors.white)),
                      InkWell(
                          onTap: () => Navigator.pushNamed(context, '/rentals'),
                          child:
                              Icon(Icons.location_city, color: Colors.white)),
                      InkWell(child: Icon(Icons.person, color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            Clientfeedback(),
          ],
        ),
      )),
    );
  }
}

class MobileMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            color: AppColors.BACKGROUND_COLOR,
            margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
            padding: EdgeInsets.only(bottom: 8),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Text(
                    '1NERD',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'Passion',
                      fontStyle: FontStyle.italic,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () => Navigator.pushNamed(context, '/account'),
                        child: Icon(Icons.apps, color: Colors.white)),
                    InkWell(child: Icon(Icons.home, color: Colors.white)),
                    InkWell(
                        onTap: () => Navigator.pushNamed(context, '/rentals'),
                        child: Icon(Icons.location_city, color: Colors.white)),
                    InkWell(child: Icon(Icons.person, color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class MenuHorizontal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: MediaQuery.of(context).size.width,
      color: AppColors.BACKGROUND_COLOR,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(8, 8, 16, 16),
                  child: Text(
                    '1NERD',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'Passion',
                        fontStyle: FontStyle.italic,
                        letterSpacing: 1),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: 150,
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Sales',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/sales');
                    },
                  ),
                ),
                Container(
                  width: 150,
                  child: ListTile(
                    leading: Icon(Icons.location_city, color: Colors.white),
                    title: Text(
                      'Rentals',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/rentals');
                    },
                  ),
                ),
                Container(
                  width: 200,
                  child: ListTile(
                    leading: Icon(Icons.edit_location, color: Colors.white),
                    title: Text(
                      'Neighborhood',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/rentals');
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text('Advertise', style: TextStyle(color: AppColors.LIGHT_GREEN)),
              SizedBox(width: 10),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                onPressed: () {},
                textColor: AppColors.BACKGROUND_COLOR,
                child: Text(
                  'Sign In / Register',
                  style: TextStyle(),
                ),
                color: AppColors.LIGHT_GREEN,
              ),
              SizedBox(width: 10)
            ],
          )
        ],
      ),
    );
  }
}
