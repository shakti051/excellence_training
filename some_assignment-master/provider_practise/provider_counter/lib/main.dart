import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//https://medium.com/@ggcsriram/flutters-provider-8f27f5c629bf

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ValueNotifier<int>>(
            create: (context) => ValueNotifier<int>(0),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,  
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: Color(0xff7cc6e9),
          ),
          home: MyHomePage(title: 'Provider Counter App'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final stateProvider = Provider.of<ValueNotifier<int>>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Consumer<ValueNotifier<int>>(
              builder: (context, data, child) => Text(
                '${data.value}',
                style: Theme.of(context).textTheme.headline4,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => stateProvider.value++,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
