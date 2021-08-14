import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dataModelClass.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DataModel coinData = DataModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    coinData.basicCall();
  }

  @override
  Widget build(BuildContext context) {
    final something = context.watch<DataModel>();
    return Scaffold(
      body: ListView.builder(
          itemCount: coinData.newCoin.length,
          itemBuilder: (context, index) {
            return Card(
              color: Color(0xff41C36C),
              child: ListTile(
                title: Text("${coinData.newCoin[index].name}"),
                onLongPress: () {
                  // coinData.newCoin.removeAt(index);
                  // Provider.of<DataModel>(context, listen: false).removeCoin();
                  something.removeCoin(index);
                },
              ),
            );
          }),
    );
  }
}
