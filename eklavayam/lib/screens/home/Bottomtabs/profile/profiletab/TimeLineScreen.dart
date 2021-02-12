import 'package:eklavayam/utill/MyColour.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeLineScreen extends StatefulWidget {

  int userid,loggeduserid;

  TimeLineScreen(this.userid,this.loggeduserid);

  @override
  _TimeLineScreenState createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {

  String name,image,mobile,token;
  int uniqueId;
  restoreSF() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      name = (sharedPrefs.getString('name') ?? "Mr.");
      image = (sharedPrefs.getString('image') ?? "");
      mobile = (sharedPrefs.getString('mobile') ?? "");
      token = (sharedPrefs.getString('token') ?? "");
      uniqueId = (sharedPrefs.getInt('uniqueId') ??0);
      // print(name + " " + image + " " + mobile + " " + token);
      //print("SFtoken> " + token);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    restoreSF();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 50,
          width: MediaQuery.of(context).size.width,
          color: orangecolor,
          child: Text("Following",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
        ),
        SizedBox(height: 5,),

Expanded(child: Center(child: Image.asset("assets/images/noresult.png"))),

      ],
    );
  }
}
