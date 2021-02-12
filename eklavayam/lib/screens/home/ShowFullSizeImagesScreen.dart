import 'package:eklavayam/screens/home/Bottomtabs/model/StoryfeedModel.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ShowFullSizeImagesScreen extends StatefulWidget {

  final List<Images> imglist;


  ShowFullSizeImagesScreen(this.imglist);

  @override
  _ShowFullSizeImagesScreenState createState() => _ShowFullSizeImagesScreenState();
}

class _ShowFullSizeImagesScreenState extends State<ShowFullSizeImagesScreen> {

  int currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: bluecolor,
      ),
      body: ExtendedImageGesturePageView.builder(
        itemBuilder: (BuildContext context, int index) {
          var item = widget.imglist[index].imgUrl;
          Widget image = ExtendedImage.network(
            item,
            fit: BoxFit.contain,
            mode: ExtendedImageMode.gesture,
            // gestureConfig: GestureConfig(
            //     inPageView: true, initialScale: 1.0,
            //     //you can cache gesture state even though page view page change.
            //     //remember call clearGestureDetailsCache() method at the right time.(for example,this page dispose)
            //     cacheGesture: false
            // ),
          );
          image = Container(
            child: image,
            padding: EdgeInsets.all(5.0),
          );
          if (index == currentIndex) {
            return Hero(
              tag: item + index.toString(),
              child: image,
            );
          } else {
            return image;
          }
        },
        itemCount: widget.imglist.length,
        onPageChanged: (int index) {
          currentIndex = index;
          //rebuild.add(index);
        },
        controller: PageController(
          initialPage: currentIndex,
        ),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
