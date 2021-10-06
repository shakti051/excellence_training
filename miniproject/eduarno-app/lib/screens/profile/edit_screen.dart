import 'package:eduarno/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Utilities/constants.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key key}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kLightGray,
      appBar: AppBar(
        backgroundColor: kLightGray,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        elevation: 0,
        title: Text(
          "Edit Details",
          style: TextStyle(
            fontSize: 18.0,
            //  color: Colors.black, fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace, color: Colors.black),
          onPressed: () => {
            ShowToast.show("Back"),
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, size: 20, color: Colors.black),
            onPressed: () => ShowToast.show("Edit"),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 12),
            child: TextField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), hintText: 'Name'),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 12),
            child: TextField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), hintText: 'Email'),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 12),
            child: TextField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), hintText: 'Phone No.'),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 12),
            child: TextField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), hintText: 'Password'),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width - 32,
                height: MediaQuery.of(context).size.height * 0.07,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: kBlueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
