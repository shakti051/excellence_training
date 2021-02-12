import 'package:eklavayam/screens/home/Bottomtabs/model/UserDetailModel.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocialMediaScreen extends StatefulWidget {
  bool me;
UserDetailModel userDetailModel;
  SocialMediaScreen(this.userDetailModel,this.me);

  @override
  _SocialMediaScreenState createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {


  String name,image,mobile,token;
  int uniqueId;
  restoreSF() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      name = (sharedPrefs.getString('name') ?? "Mr.");
      image = (sharedPrefs.getString('image') ?? "");
      mobile = (sharedPrefs.getString('mobile') ?? "");
      token = (sharedPrefs.getString('token') ?? "");
      uniqueId = (sharedPrefs.getInt('uniqueId') ?? 0);
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
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child:  Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/fb.png",
                          height: 40,
                          width: 40,
                          fit: BoxFit.fill,
                        ),
                        Expanded(child: Container(
                          height: 50,
                          color: bluecolorlight,
child: Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Text(widget.userDetailModel.data[0].facebookURL,style: TextStyle(color: bluecolor),),
),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/twitter.png",
                          height: 40,
                          width: 40,
                          fit: BoxFit.fill,
                        ),
                        Expanded(child: Container(
                          height: 50,
                          color: bluecolorlight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.userDetailModel.data[0].twitterURL??"",style: TextStyle(color: bluecolor),),
                          ),
                        ))
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/insta.png",
                          height: 40,
                          width: 40,
                          fit: BoxFit.fill,
                        ),
                        Expanded(child: Container(
                          height: 50,
                          color: bluecolorlight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.userDetailModel.data[0].instagramURL??"",style: TextStyle(color: bluecolor),),
                          ),
                        ))
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      children: [
                        Image.asset(
                          "assets/images/youtube.png",
                          height: 40,
                          width: 40,
                          fit: BoxFit.fill,
                        ),
                        Expanded(child: Container(
                          height: 50,
                          color: bluecolorlight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.userDetailModel.data[0].youTubeURL??"",style: TextStyle(color: bluecolor),),
                          ),
                        ))
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/linkidin.png",
                          height: 40,
                          width: 40,
                          fit: BoxFit.fill,
                        ),

                        Expanded(child: Container(
                          height: 50,
                          color: bluecolorlight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.userDetailModel.data[0].linkedInURL??"",style: TextStyle(color: bluecolor),),
                          ),
                        ))
                      ],
                    ),

                    SizedBox(
                      width: 10,
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
