import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class RecomendAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000.0,
      width: (MediaQuery.of(context).size.width < 850 ||
              MediaQuery.of(context).size.height < 600)
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width - 200,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return RecomendList();
        },
      ),
    );
  }
}

class RecomendList extends StatelessWidget {
  String addr = """2130 ADAM CLATON POWSHELL""";
  @override
  Widget build(BuildContext context) {
    return (MediaQuery.of(context).size.width < 850 ||
            MediaQuery.of(context).size.height < 600)
        ? Column(
            children: [
              leftRecomendList(context),
              rightRecomendList(context),
            ],
          )
        : Row(
            children: [
              leftRecomendList(context),
              SizedBox(width: 20),
              rightRecomendList(context)
            ],
          );
  }

  Widget leftRecomendList(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            Container(
              height: 140,
              child: Image(
                image: AssetImage('assets/images/hotel.png'),
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: 140,
              color: Colors.white,
              width: (MediaQuery.of(context).size.width < 850 ||
                      MediaQuery.of(context).size.height < 600)
                  ? MediaQuery.of(context).size.width - 160
                  : MediaQuery.of(context).size.width * .25,
              child: ListTile(
                trailing: Icon(Icons.favorite, color: Colors.redAccent),
                title: Row(
                  children: [
                    Text('For Rent',
                        style:
                            TextStyle(fontFamily: 'Lato', color: Colors.pink)),
                    SizedBox(width: 20),
                    Text('West Village',
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Open',
                            color: Colors.black54)),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(addr,
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontFamily: 'Lato',
                            fontSize: 13)),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text('\$2,300',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black)),
                        SizedBox(width: 20),
                        Text('2 Bed',
                            style:
                                TextStyle(fontSize: 14, color: Colors.black)),
                        SizedBox(width: 10),
                        Text('2 Bath',
                            style: TextStyle(fontSize: 14, color: Colors.black))
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundImage:
                                    AssetImage('assets/images/agent.png'),
                              ),
                              SizedBox(width: 5),
                              Text('Zach Lachmiez',
                                  style: TextStyle(fontSize: 12))
                            ],
                          ),
                        ),
                        (MediaQuery.of(context).size.width < 850 ||
                                MediaQuery.of(context).size.height < 600)
                            ? Container()
                            : Container(
                                height: 20,
                                width: 120,
                                child: RaisedButton(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  onPressed: () {},
                                  color: AppColors.LIGHT_PINK,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'recommended',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.red[300],
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.red[300],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                    (MediaQuery.of(context).size.width < 850 ||
                            MediaQuery.of(context).size.height < 600)
                        ? Container(
                            height: 20,
                            width: 120,
                            margin: EdgeInsets.only(top: 5),
                            child: RaisedButton(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              onPressed: () {},
                              color: AppColors.LIGHT_PINK,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'recommended',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red[300],
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.red[300],
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget rightRecomendList(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            Container(
              height: 140,
              child: Image(
                image: AssetImage('assets/images/hotel.png'),
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: 140,
              color: Colors.white,
              width: (MediaQuery.of(context).size.width < 850 ||
                      MediaQuery.of(context).size.height < 600)
                  ? MediaQuery.of(context).size.width - 160
                  : MediaQuery.of(context).size.width * .25,
              child: ListTile(
                trailing: Icon(Icons.favorite, color: Colors.redAccent),
                title: Row(
                  children: [
                    Text('For Rent',
                        style:
                            TextStyle(fontFamily: 'Lato', color: Colors.pink)),
                    SizedBox(width: 20),
                    Text('West Village',
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Open',
                            color: Colors.black54)),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(addr,
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontFamily: 'Lato',
                            fontSize: 13)),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text('\$2,300',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black)),
                        SizedBox(width: 20),
                        Text('2 Bed',
                            style:
                                TextStyle(fontSize: 14, color: Colors.black)),
                        SizedBox(width: 10),
                        Text('2 Bath',
                            style: TextStyle(fontSize: 14, color: Colors.black))
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundImage:
                                    AssetImage('assets/images/agent.png'),
                              ),
                              SizedBox(width: 5),
                              Text('Zach Lachmiez',
                                  style: TextStyle(fontSize: 12))
                            ],
                          ),
                        ),
                        (MediaQuery.of(context).size.width < 850 ||
                                MediaQuery.of(context).size.height < 600)
                            ? Container()
                            : Container(
                                height: 20,
                                width: 120,
                                child: RaisedButton(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  onPressed: () {},
                                  color: AppColors.LIGHT_PINK,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'recommended',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.red[300],
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.red[300],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                    (MediaQuery.of(context).size.width < 850 ||
                            MediaQuery.of(context).size.height < 600)
                        ? Container(
                            height: 20,
                            width: 120,
                            margin: EdgeInsets.only(top: 5),
                            child: RaisedButton(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              onPressed: () {},
                              color: AppColors.LIGHT_PINK,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'recommended',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red[300],
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.red[300],
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
