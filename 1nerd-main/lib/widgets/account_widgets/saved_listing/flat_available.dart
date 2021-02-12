import 'package:flutter/material.dart';

class FlatAvailable extends StatelessWidget {
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
        itemCount: 103,
        itemBuilder: (BuildContext context, int index) {
          return FlatList();
        },
      ),
    );
  }
}

class FlatList extends StatelessWidget {
  String addr = """2130 ADAM CLATON POWSHELL""";
  @override
  Widget build(BuildContext context) {
    return (MediaQuery.of(context).size.width < 850 ||
            MediaQuery.of(context).size.height < 600)
        ? Column(
            children: [
              leftList(context),
              rightList(context),
            ],
          )
        : Row(
            children: [
              leftList(context),
              SizedBox(width: 20),
              rightList(context)
            ],
          );
  }

  Widget leftList(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            Image(
              image: AssetImage('assets/images/hotel.png'),
              fit: BoxFit.fitHeight,
            ),
            Container(
              height: 110,
              color: Colors.white,
              width: (MediaQuery.of(context).size.width < 850 ||
                      MediaQuery.of(context).size.height < 600)
                  ? MediaQuery.of(context).size.width - 130
                  : MediaQuery.of(context).size.width * .25,
              child: ListTile(
                trailing: Icon(Icons.favorite, color: Colors.redAccent),
                title: Row(
                  children: [
                    Text('For Rent',
                        style:
                            TextStyle(fontFamily: 'Lato', color: Colors.pink)),
                    SizedBox(
                        width: (MediaQuery.of(context).size.width < 850 ||
                                MediaQuery.of(context).size.height < 600)
                            ? 10
                            : 20),
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
                    SizedBox(height: 10),
                    Text(addr,
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontFamily: 'Lato',
                            fontSize: 16)),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget rightList(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            Image(
              image: AssetImage('assets/images/hotel.png'),
              fit: BoxFit.fitHeight,
            ),
            Container(
              height: 110,
              color: Colors.white,
              width: (MediaQuery.of(context).size.width < 850 ||
                      MediaQuery.of(context).size.height < 600)
                  ? MediaQuery.of(context).size.width - 130
                  : MediaQuery.of(context).size.width * .25,
              child: ListTile(
                trailing: Icon(Icons.favorite, color: Colors.redAccent),
                title: Row(
                  children: [
                    Text('For Rent',
                        style:
                            TextStyle(fontFamily: 'Lato', color: Colors.pink)),
                    SizedBox(
                        width: (MediaQuery.of(context).size.width < 850 ||
                                MediaQuery.of(context).size.height < 600)
                            ? 10
                            : 20),
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
                    SizedBox(height: 10),
                    Text(addr,
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontFamily: 'Lato',
                            fontSize: 16)),
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
