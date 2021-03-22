import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_app/compare/hotelsscreen.dart';
import '../places_button.dart';

class PlacesScreen extends StatelessWidget {
  final String pageTitle;

  PlacesScreen({this.pageTitle});

  void toHotelsPage(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Hotels();
        },
      ),
    );
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
                        pageTitle,
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
                Divider(
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              PlacesButton(
                title: 'Pondicherry',
                distanceTitle: '22',
                imageUrl: 'beachimages/beach1.jpg',
                navigate: () => toHotelsPage(context),
              ),
              PlacesButton(
                title: 'Goa',
                distanceTitle: '25',
                imageUrl: 'beachimages/beach2.jpg',
              ),
              PlacesButton(
                title: 'Juhu Beach',
                distanceTitle: '24',
                imageUrl: 'beachimages/beach3.jpg',
              ),
              PlacesButton(
                  title: 'Goa',
                  distanceTitle: '28',
                  imageUrl: 'beachimages/beach4.jpg'),
              PlacesButton(
                  title: 'Pondicherry',
                  distanceTitle: '21',
                  imageUrl: 'beachimages/beach5.jpg'),
            ],
          ),
        ),
      ),
    );
  }
}
