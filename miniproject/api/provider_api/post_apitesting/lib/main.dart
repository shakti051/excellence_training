import 'package:flutter/material.dart';
import 'package:post_apitesting/model/interest_model.dart';
import 'package:post_apitesting/provider/interest_provider.dart';
import 'package:post_apitesting/service/interest_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InterestProvider(),
      child: MaterialApp(
        title: 'Provider Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: InterestPage(),
      ),
    );
  }
}

class InterestPage extends StatefulWidget {
  const InterestPage({Key key}) : super(key: key);

  @override
  _InterestPageState createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  InterestService apiInterest = InterestService();
  InterestModel interestModel;
  
  bool apiHit = false;
  _getInterestList() async {
    return await apiInterest.getInterest().then((value) {
      interestModel = value;
      Provider.of<InterestProvider>(context, listen: false).toggleDone();
      // setState(() {
      //   apiHit = true;
      // });
    });
  }

  @override
  void initState() {
    _getInterestList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      body: Provider.of<InterestProvider>(context).getAPiHit
          ? ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: interestModel.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    onLongPress: () {
                      Provider.of<InterestProvider>(context,listen: false).RemoveSkill(index);
                    },
                    leading: Text(interestModel.data[index].specialiation));
                // InkWell(
                //   onLongPress: () {
                //     interestModel.data.removeAt(index);
                //   },
                //   child: Container(
                //       margin: EdgeInsets.only(left: 8, bottom: 8),
                //       padding:
                //           EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                //       height: 40,
                //       decoration: BoxDecoration(
                //           color: Colors.green,
                //           borderRadius: BorderRadius.all(Radius.circular(5))),
                //       child: Text(interestModel.data[index].specialiation,
                //           textAlign: TextAlign.center,
                //           style: TextStyle(color: Colors.white, fontSize: 14))),
                // );
              })
          : Center(child: CircularProgressIndicator()),
    );
  }
}
