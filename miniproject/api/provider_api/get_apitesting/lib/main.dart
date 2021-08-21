import 'package:flutter/material.dart';
import 'package:get_apitesting/specialisation_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SpecialisationProvider(),
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue),
          home: MyData()),
    );
  }
}

class MyData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SpecialisationProvider>(context);
    return Scaffold(body: Consumer<SpecialisationProvider>(
      builder: (context, myModel, child) {
        if (myModel.homeState == HomeState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (myModel.homeState == HomeState.Loaded) {
          return ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: myModel.allSpecialisation.data.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onLongPress: () {
                    myModel.delete(index);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 8, bottom: 8),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Text(model.yourSkills.data[index].specialisation,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                  ),
                );
              });
        } else if (myModel.homeState == HomeState.Error) {
          return Center(child: Text('An Error Occured ${model.message}'));
        } else
          throw Exception('Failed to load specialisation');
      },
    ));
  }
}
