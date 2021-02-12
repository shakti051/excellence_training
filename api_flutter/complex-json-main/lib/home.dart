import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  List listOf;
  Home(this.listOf);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  List<MaterialColor> _color = [
    Colors.indigo,
    Colors.amber,
    Colors.purple,
    Colors.deepOrange
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('complex json parsing'),
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(
              onPressed: () => print('search'), icon: Icon(Icons.search)),
          IconButton(onPressed: () => print('title'), icon: Icon(Icons.title)),
        ],
      ),
      body: ListView(children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: widget.listOf.length,
            itemBuilder: (BuildContext context, int index) {
              MaterialColor mcolor = _color[index % _color.length];
              return Card(
                elevation: 10,
                margin: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: CircleAvatar(
                        child: Text(widget.listOf[index]["id"].toString()[0]),
                        backgroundColor: mcolor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    Container(
                        width: 200,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.listOf[index]["name"],
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(height: 4),
                              Text(
                                widget.listOf[index]["username"],
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(height: 4),
                              Text(
                                widget.listOf[index]["email"],
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(height: 4),
                              Text(
                                widget.listOf[index]["address"]["suite"],
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(height: 4),
                              Text(
                                widget.listOf[index]["address"]["city"],
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(height: 4),
                              Text(
                                widget.listOf[index]["address"]["zipcode"],
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(height: 4),
                              Text(
                                widget.listOf[index]["address"]["geo"]["lat"],
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(height: 4),
                              Text(
                                widget.listOf[index]["address"]["geo"]["lng"],
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(height: 4),
                              Text(
                                widget.listOf[index]["phone"],
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(height: 4),
                              Text(
                                widget.listOf[index]["website"],
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(height: 4),
                              Text(
                                widget.listOf[index]["company"]["name"],
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(height: 4),
                              Text(
                                widget.listOf[index]["company"]["catchPhrase"],
                                style: TextStyle(fontSize: 17),
                                maxLines: 1,
                              ),
                              SizedBox(height: 4),
                              Text(
                                widget.listOf[index]["company"]["bs"],
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(height: 4),
                            ]))
                  ],
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}