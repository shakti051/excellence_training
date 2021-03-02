import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class CarouselPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .7,
              height: 250,
              child: Carousel(
                boxFit: BoxFit.cover,
                autoplay: true,
                animationCurve: Curves.fastOutSlowIn,
                animationDuration: Duration(milliseconds: 1000),
                dotSize: 6.0,
                dotIncreasedColor: Color(0xFFFF335C),
                dotBgColor: Colors.transparent,
                dotPosition: DotPosition.bottomLeft,
                dotVerticalPadding: 10.0,
                showIndicator: true,
                indicatorBgPadding: 7.0,
                autoplayDuration: Duration(seconds: 3),
                images: [
                  NetworkImage('https://picsum.photos/250?image=9'),
                  NetworkImage('https://picsum.photos/250?image=10'),
                  NetworkImage('https://picsum.photos/250?image=11'),
                  NetworkImage('https://picsum.photos/250?image=12'),
                ],
              ),
            ),
            Positioned(bottom: 10, right: 10, child: Icon(Icons.ac_unit_sharp)),
            Positioned(top: 10, right: 10, child: Icon(Icons.share)),
          ],
        ),
      ),
    );
  }
}
