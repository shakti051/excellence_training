import 'package:flutter/material.dart';
import 'package:pay_app/filter_screen.dart';
import 'package:pay_app/iconscreens/place_screen.dart';

class CategoriesScreen extends StatelessWidget {
  final List data = [
    {
      "images":
          "https://images.pexels.com/photos/1707820/pexels-photo-1707820.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      "text": "Cannada",
    },
    {
      "images":
          "https://thumbs.dreamstime.com/z/purple-desert-prickly-pear-opuntia-cactus-growing-desert-sun-horseshoe-canyon-drumheller-alberta-cannada-190969523.jpg",
      "text": "USA",
    },
    {
      "images":
          "https://images.pexels.com/photos/169647/pexels-photo-169647.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      "text": "Australia",
    },
  ];

  final List _imagesList = [
    {
      'images': 'images/beach.jpg',
      'text': 'Beach',
    },
    {
      'images': 'images/heritage.png',
      'text': 'Heritage',
    },
    {
      'images': 'images/heart.png',
      'text': 'Romantic',
    },
    {
      'images': 'images/hill.png',
      'text': 'Hill',
    },
    {
      'images': 'images/wildlife.png',
      'text': 'Wildlife',
    },
  ];

  Widget buildBottomSheet(BuildContext context) {
    return FilterScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
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
                        'Categories',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
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
                  width: MediaQuery.of(context).size.width,
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
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: buildBottomSheet,
                        );
                      },
                      child: Text(
                        'Filters',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff5CADFF),
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_downward,
                      color: Color(0xff5CADFF),
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.black,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 70,
                          width: 340,
                          child: ListView.builder(
                            itemCount: _imagesList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (filterItem, i) => Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PlacesScreen(
                                          pageTitle: _imagesList[i]['text'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 60,
                                    margin: EdgeInsets.only(right: 10),
                                    width: 60,
                                    decoration: BoxDecoration(
                                      //borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                        image: ExactAssetImage(
                                          _imagesList[i]['images'],
                                        ),
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 7),
                                  child: Text(
                                    _imagesList[i]['text'],
                                    style: TextStyle(fontSize: 7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular in Canada",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      child: Text(
                        "View All",
                        style: TextStyle(
                          color: Color(0xff5CADFF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, i) => Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      //color: Colors.black54,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [
                          Colors.black87,
                          Colors.black38,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            image: DecorationImage(
                                image: NetworkImage(
                                  data[i]["images"],
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 10),
                          height: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Text(
                                  data[i]["text"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 17),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Itealy",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
