import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      create: (context) => Data(),
      child: MaterialApp(
        title: 'Provider Introduction',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(appBar: AppBar(title: MyData()), body: Level1()),
      ),
    );
  }
}

class Level1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Level2());
  }
}

class Level2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [MyTextFeild(), Level3()]);
  }
}

class Level3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text(Provider.of<Data>(context).data));
  }
}

class MyData extends StatelessWidget {
  const MyData({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(Provider.of<Data>(context,listen: false).data);
  }
}

class MyTextFeild extends StatelessWidget {
  const MyTextFeild({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (newValue) {
        Provider.of<Data>(context).changeString(newValue);
      },
    );
  }
}

class Data extends ChangeNotifier {
  String data = 'Some Data';
  void changeString(String newString) {
    data = newString;
    notifyListeners();
  }
}
