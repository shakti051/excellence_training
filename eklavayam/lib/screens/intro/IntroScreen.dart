import 'package:eklavayam/screens/authentication/login_signup/ui/login_page.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';


class IntroScreen extends StatelessWidget {

  final pages = [
    PageViewModel(
        pageColor: const Color.fromARGB(255, 251, 186, 0),
        // iconImageAssetPath: 'assets/air-hostess.png',
        bubble: Image.asset('assets/images/art.png'),

        body: Text(
          'ART is a state of grace and Culture.It expresses the idea of Literature',
        ),
        title: Text(
          'ART',
        ),
        titleTextStyle: TextStyle( color: Colors.white),
        bodyTextStyle: TextStyle(color: Colors.white),
        mainImage: Image.asset(
          'assets/images/art.png',
          // height: 285.0,
          // width: 285.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: const Color.fromARGB(255, 24, 34, 68),
      iconImageAssetPath: 'assets/images/Literature.png',
      body: Text(
        'LITERATURE is art which speaks and reveal the view point of culture.',
      ),
      title: Text('LITERATURE'),
      mainImage: Image.asset(
        'assets/images/Literature.png',

        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle( color: Colors.white),
      bodyTextStyle: TextStyle( color: Colors.white),
    ),
    PageViewModel(
      pageColor: const Color.fromARGB(255, 0, 163, 199),
      iconImageAssetPath: 'assets/images/Culture.png',
      body: Text(
        'CULTURE dmonstrate the belief through art and streaththen the identity of Litrature.',
      ),
      title: Text('CULTURE'),
      mainImage: Image.asset(
        'assets/images/Culture.png',

        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle( color: Colors.white),
      bodyTextStyle: TextStyle( color: Colors.white),
    ),
  ];








  @override
  Widget build(BuildContext context) {
return Scaffold(

  body:  Container(

    child: Builder(
      builder: (context) => IntroViewsFlutter(

        pages,
        showNextButton: true,
        showBackButton: true,
        showSkipButton: true,
        onTapDoneButton: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ), //MaterialPageRoute
          );
        },
        onTapSkipButton: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ), //MaterialPageRoute
          );
        },
        pageButtonTextStyles: TextStyle(
          color: Colors.white,

          fontSize: 18.0,
        ),
      ), //IntroViewsFlutter
    ),
  ),
);
  }
}
