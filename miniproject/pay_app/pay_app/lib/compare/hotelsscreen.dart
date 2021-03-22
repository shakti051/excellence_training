import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:pay_app/hoteldetails_screen.dart';

class Hotels extends StatelessWidget {
  final List hotelData = [
    {
      'hotelsImages': 'hotelsimages/hotel3.jpg',
      'text': 'Radission Blue Resort',
    },
    {
      'hotelsImages': 'hotelsimages/hotel1.jpg',
      'text': 'Grand Goa Resort',
    },
    {
      'hotelsImages': 'hotelsimages/hotel2.jpg',
      'text': 'Silk Cotton Resort',
    },
    {
      'hotelsImages': 'hotelsimages/hotel5.jpg',
      'text': 'Coconot Grove Resort',
    },
  ];

  void toHotelDetailsScreen(BuildContext ctx){
    Navigator.of(ctx).push(MaterialPageRoute(
      builder: (_) => HotelDetails(),),);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('images/pic.jpg'),
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  //color: Colors.transparent,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Hotels',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffCFCFCF),
                  ),
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 12.0,
                    right: 12.0,
                  ),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Color(0xff474747),
                              ),
                              hintText: "Search",
                              hintStyle: TextStyle(
                                color: Color(0xff474747),
                              ),
                              border: InputBorder.none,
                            ),
                            //autofocus: true,
                            onTap: () {
                              // showSearch(context: context, delegate: DataSearch());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: hotelData.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (ctx, i) =>
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                margin: EdgeInsets.only(left: 7, right: 7, bottom: 15),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  elevation: 14,
                  shadowColor: Color(0x802196F3),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Container(
                        //   height: 200,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.only(
                        //       topRight: Radius.circular(20),
                        //       topLeft: Radius.circular(20),
                        //     ),
                        //     // image: DecorationImage(
                        //     //   fit: BoxFit.cover,
                        //     //   image: ExactAssetImage(
                        //     //     hotelData[i]['hotelsImages'],
                        //     //   ),
                        //     // ),
                        //   ),
                        // child: Container(
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: InkWell(
                            onTap: () => toHotelDetailsScreen(context),
                            child: Carousel(
                              dotColor: Color(0xff8F00D6),
                              indicatorBgPadding: 7.0,
                              autoplay: false,
                              images: [
                                ClipRRect(
                                  child: Image.asset('hotelsimages/hotel1.jpg',
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                ClipRRect(
                                  child: Image.asset('hotelsimages/hotel2.jpg',
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  ),
                                ),
                                ClipRRect(
                                  child: Image.asset('hotelsimages/hotel3.jpg',
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 220,
                          margin: EdgeInsets.only(left: 7, right: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          //margin: EdgeInsets.only(right: 10, left: 10),
                          //width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () => toHotelDetailsScreen(context),
                                child: Text(
                                  hotelData[i]['text'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25,
                                      fontFamily: 'Poppins',
                                      color: Colors.blueGrey),
                                ),
                              ),
                              InkWell(
                                onTap: () => toHotelDetailsScreen(context),
                                child: Text(
                                  'Temple Bay is a beach resort intelligently is designed to offer the best of comfort and leisure. Beach facing and far from the hustle of the city, this resort blends the beach.',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Divider(color: Colors.black12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                children: [
                                  Icon(Icons.rate_review),
                                  Text('REVIEWS'),
                                  SizedBox(height: 20),
                                  Icon(Icons.add_circle),
                                  Text('COMPARE'),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                children: [
                                  Container(
                                    child: Center(
                                      child: Text(
                                        '₹7392',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          Color(0xff8F00D6),
                                          Color(0xffA42AC3),
                                        ],
                                      ),
                                    ),
                                    width: 150,
                                    height: 40,
                                  ),
                                  Container(
                                    width: 150,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          Color(0xff8F00D6),
                                          Color(0xffA42AC3),
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Offers',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
