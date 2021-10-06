import 'package:demo_reusable/screens/login_screen.dart';
import 'package:demo_reusable/utils/appsettings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    HomeApp(),
  );
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppSettings(),
        ),
      ],
      child: MaterialApp(
        title: 'Timeline',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
