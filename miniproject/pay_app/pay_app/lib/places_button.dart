import 'package:flutter/material.dart';

class PlacesButton extends StatelessWidget {
  final String title;
  final String distanceTitle;
  final String imageUrl;
  final Function navigate;


  PlacesButton({@required this.title, @required this.distanceTitle, @required this.imageUrl, this.navigate});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigate,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
        child: Material(
          color: Colors.white,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(24.0),
          shadowColor: Color(0x802196F3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width/2,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.0),
                  child: Image(
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topLeft,
                    image: AssetImage('$imageUrl'),
                  ),
                ),
              ),
               Container(
                 margin: EdgeInsets.only(right: 40),
                 alignment: Alignment.center,
                 child: Column(
                    children:[
                    Text(
                      title,
                      style: TextStyle(
                        color: Color(0xff8F00D6),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                      Text('From Delhi $distanceTitle km'),
                   ],
                  ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}