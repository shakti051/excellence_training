import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> listOf = [
    "Apple",
    "Food",
    "Product",
    "Item",
    "List View",
    "New App",
    "Design",
    "Job"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Title(
              color: Colors.white,
              child: Text(
                "",textAlign: TextAlign.center,
                style: TextStyle(fontSize: 19),
              )),
          IconButton(icon: Icon(Icons.add), onPressed: () => debugPrint("Add")),
          IconButton(
              icon: Icon(Icons.search), onPressed: () => debugPrint("Search")),
        ],
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        margin: EdgeInsets.all(6),
        padding: EdgeInsets.all(6),
        child: ListView.builder(
		scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, int index) => listDataItems(this.listOf[index]),itemCount: this.listOf.length,),
      ),
      floatingActionButton: FloatingActionButton(foregroundColor: Colors.white,backgroundColor: Colors.deepPurple,child: Icon(Icons.add),),
    );
  }
}

class listDataItems extends StatelessWidget {
  String itemName;
  listDataItems(this.itemName);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7.0,
      child: Container(
        margin: EdgeInsets.all(7),
        padding: EdgeInsets.all(6),
        child: Row(children: <Widget>[
          CircleAvatar(
            child: Text("1"),
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
            Padding(padding: EdgeInsets.all(8)),
          Text(
            itemName,
            style: TextStyle(fontSize: 20),
          )
        ]),
      ),
    );
  }
}
