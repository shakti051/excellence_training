import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

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
    return Container(
      color: Colors.grey.shade50,
      height: Get.height,
      width: Get.width,

      child: Column(
        children: [

          SizedBox(height: 100,),

          Container(
      margin: EdgeInsets.all(15),
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Card(
            color: Colors.grey.shade100,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0)),
            child: Container(
                padding: EdgeInsets.all(1),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  //color: bluecolor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person)),
          ),
          SizedBox(width: 5,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Edit Information",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                SizedBox(height: 5),
                Text("Modify personal details",maxLines: 3,),
              ],
            ),
          ),
        ],
      ),
    ),



          Container(
            margin: EdgeInsets.all(15),
            height: 80,
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Card(
                  color: Colors.grey.shade100,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0)),
                  child: Container(
                      padding: EdgeInsets.all(1),
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        //color: bluecolor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person)),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Edit Interest",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                      SizedBox(height: 5),
                      Text("Modify your selected interest",maxLines: 3,),
                    ],
                  ),
                ),
              ],
            ),
          ),



          Container(
            margin: EdgeInsets.all(15),
            height: 80,
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Card(
                  color: Colors.grey.shade100,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0)),
                  child: Container(
                      padding: EdgeInsets.all(1),
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        //color: bluecolor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person)),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Edit Language",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                      SizedBox(height: 5),
                      Text("Modify your selected Language",maxLines: 3,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}
