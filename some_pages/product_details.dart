import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:payizadlt/view/screens/e_shopping_screen.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:readmore/readmore.dart';
import 'package:payizadlt/utility/colorResources.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool liked = false;
  int _counter = 1;
  
  _pressed() {
    setState(() {
      liked = !liked;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 1) _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.blue, Colors.purple])),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EShoppingScreen()),
                        );
                      },
                      child: Container(
                          margin: EdgeInsets.all(8),
                          child: Icon(Icons.navigate_before,
                              color: Colors.white, size: 30)),
                    ),
                    Container(
                        margin: EdgeInsets.all(8),
                        child: Icon(Icons.shopping_cart_rounded,
                            color: Colors.white, size: 24)),
                  ],
                ),
                slider(context),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Rs.429",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "MRP:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Rs.1999 ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Product Details:",
                        style: TextStyle(color: Colors.white, fontSize: 20))),
                readMore(),
                SizedBox(height: 8),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Text("Quantity:",
                        style: TextStyle(color: Colors.white, fontSize: 20))),
                qty(),
                buyNow(),
                addcart(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget slider(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
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
                  //  AssetImage("assets/images/bag1.png"),
                  NetworkImage('https://picsum.photos/250?image=9'),
                  NetworkImage('https://picsum.photos/250?image=10'),
                  NetworkImage('https://picsum.photos/250?image=11'),
                  // NetworkImage(
                  //     'https://picsum.photos/250?image=12'),
                ],
              ),
            ),
            Positioned(
                top: 10,
                right: 10,
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                )),
            Positioned(
                bottom: 10,
                right: 10,
                child: InkWell(
                  onTap: () {
                    _pressed();
                  },
                  child: Icon(
                    liked ? Icons.favorite : Icons.favorite_sharp,
                    color: liked ? Colors.red : Colors.white,
                  ),
                )),
            // Positioned(
            //   top: 10,
            //   left: 10,
            //   child: CircleAvatar(
            //     child: Text("1"),
            //     backgroundColor: Colors.deepPurple,
            //     foregroundColor: Colors.white,
            //   ),
            // ),
          ],
        ),
      ],
    );
  }

  Widget readMore() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ReadMoreText(
        """Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.""",
        style: TextStyle(fontSize: 16, color: Colors.white),
        trimLines: 2,
        colorClickableText: ColorResources.COLOR_DARK_ORCHID,
        trimMode: TrimMode.Line,
        trimCollapsedText: 'Show more',
        trimExpandedText: 'Show less',
        moreStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorResources.COLOR_DARK_ORCHID),
      ),
    );
  }

  Widget qty() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            _decrementCounter();
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              color: ColorResources.COLOR_DARK_ORCHID,
            ),
            margin: EdgeInsets.only(left: 16),
            child: Icon(
              Icons.remove,
              color: Colors.white,
              size: 34,
            ),
          ),
        ),
        Container(
          width: 40,
          height: 36,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
            ),
            color: ColorResources.COLOR_DARK_ORCHID,
          ),
          child: Text(
            '$_counter',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        InkWell(
          onTap: () {
            _incrementCounter();
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              color: ColorResources.COLOR_DARK_ORCHID,
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 34,
            ),
          ),
        ),
      ],
    );
  }

  Widget buyNow() {
    return Container(
      width: double.infinity,
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: ColorResources.COLOR_DARK_ORCHID)),
        color: ColorResources.COLOR_DARK_ORCHID,
        child: Text(
          "Buy Now",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget addcart() {
    return Container(
      width: double.infinity,
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: ColorResources.COLOR_DARK_ORCHID)),
        color: ColorResources.COLOR_DARK_ORCHID,
        child: Text(
          "Add to Cart",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {},
      ),
    );
  }
}