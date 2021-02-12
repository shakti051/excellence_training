import 'package:eklavayam/screens/authentication/login_signup/ui/login_page.dart';
import 'package:eklavayam/screens/home/HomeDrawerBottomScreen.dart';
import 'package:eklavayam/screens/home/Home_Drwawer_Screen.dart';
import 'package:eklavayam/screens/intro/IntroScreen.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin  {
  Animation<double> animation;
  AnimationController _controller;

  Animation<double> animationbt;
  AnimationController animationControllerbt;

  AnimationController animationfade;
  Animation<double> _fadeInFadeOut;
  TickerProvider vsync;

  bool login=false;

  restoreSF() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      // name = (sharedPrefs.getString('name') ?? "Mr.");
      // image = (sharedPrefs.getString('image') ?? "");
      // mobile = (sharedPrefs.getString('mobile') ?? "");
      // token = (sharedPrefs.getString('token') ?? "");
     // uniqueId = (sharedPrefs.getInt('uniqueId') ?? "  ");
      // print(name + " " + image + " " + mobile + " " + token);
      //print("SFtoken> " + token);
    });
  }
  @override
  void initState() {
    super.initState();
//size small to big
    _controller =
        new AnimationController(vsync: this, duration: Duration(seconds: 3))
          ..forward(); //..repeat()
    animation = new CurvedAnimation(parent: _controller, curve: Curves.linear);



    //slide bottom to center
    animationControllerbt =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationbt =
        Tween<double>(begin: 0, end: -180).animate(animationControllerbt);
    animationControllerbt.forward();


//fade in out
    animationfade = AnimationController(vsync: this, duration: Duration(seconds: 3),);
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1.0).animate(animationfade);

    // animationfade.addStatusListener((status){
    //   if(status == AnimationStatus.completed){
    //     animationfade.reverse();
    //   }
    //   else if(status == AnimationStatus.dismissed){
    //     animationfade.forward();
    //   }
    // });
    animationfade.forward();



    Future.delayed(Duration(seconds: 5), () {
      // 5s over, navigate to a new page
      gotonextPage();//IntroScreen
    });
  }

  gotonextPage() async
  {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
   login= (sharedPrefs.getBool('login') ?? false);

    if(login)
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeDrawerBottomScreen()));
      }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>IntroScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: AlignmentDirectional(0.0, -0.23),
           // alignment: AlignmentDirectional.center,
            child: ScaleTransition(
              scale: animation,
              child: new Container(
                decoration: new BoxDecoration(
                    color: whitecolor, shape: BoxShape.circle),
                height: 150.0,
                width: 170.0,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      "assets/images/penlogo.png",
                      height: 150,
                      width: 170,
                    )),
              ),
            ),
          ),
          Align(
            //alignment: AlignmentDirectional(-0.0, 0.5),
            alignment: FractionalOffset.bottomCenter,
            child: AnimatedBuilder(
                animation: animationbt,
                builder: (BuildContext context, Widget chile) {
                  return Transform.translate(
                    offset: Offset(0, animationbt.value),
                    child: Container(
                      height: 250,

                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Image.asset("assets/images/logotxt.png",height: 250,width: 300,),
                        // child: Text(
                        //   "Eklavayam Creation",
                        //   style: TextStyle(
                        //       color: orangecolor,
                        //       fontSize: 22,
                        //       fontWeight: FontWeight.bold),
                        // ),
                      ),
                      // decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //       image: AssetImage('assets/images/ironman.png'),
                      //     )),
                    ),
                  );
                }),
          ),
          // Text("Eklavayam Creation",style: TextStyle(color: orangecolor,fontSize: 22,fontWeight: FontWeight.bold),),

          Align(
              alignment: AlignmentDirectional(0.0, 0.5),
              child: FadeTransition(
                opacity: _fadeInFadeOut,
                child: Text("ART | LITERATURE | CULTURE",
                    style: TextStyle(
                        color: bluecolor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              )),
        ],
      ),
    );
  }
}
