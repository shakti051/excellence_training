import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_provider/mymodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final  val = Provider.of<MyModel>(context,listen: false);
    return ChangeNotifierProvider<MyModel>(
      create: (context) => MyModel(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Simple Provider')),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.all(20),
                      color: Colors.green[200],
                      child: Consumer<MyModel>(
                        builder: (context, myModel, child) {
                          return RaisedButton(
                            child: Text('Do something'),
                            onPressed: () {
                              myModel.doSomething();
                            },
                          );
                        },
                      )),
                  Container(
                      padding: const EdgeInsets.all(35),
                      color: Colors.blue[200],
                      child:
                          Consumer<MyModel>(builder: (context, myModel, child) {
                        return Text(myModel.getSomeValue);
                      }))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
