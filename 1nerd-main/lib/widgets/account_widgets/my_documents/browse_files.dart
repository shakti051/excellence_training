import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:feedback/resources/app_colors.dart';

class BrowseFiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      color: Colors.white,
      width: (MediaQuery.of(context).size.width < 850 ||
              MediaQuery.of(context).size.height < 600)
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width - 200,
      padding: EdgeInsets.only(left: 16, top: 16, right: 16),
      margin: (MediaQuery.of(context).size.width < 850 ||
              MediaQuery.of(context).size.height < 600)
          ? EdgeInsets.only(left: 16, right: 16)
          : EdgeInsets.all(0),
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Files();
        },
      ),
    );
  }
}

class Files extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DottedBorder(
          borderType: BorderType.RRect,
          color: Colors.grey,
          radius: Radius.circular(0),
          padding: EdgeInsets.all(6),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Container(
                height: 90,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: (MediaQuery.of(context).size.width < 850 ||
                          MediaQuery.of(context).size.height < 600)
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    Column(
                      children: <Widget>[
                        Icon(
                          Icons.cloud_upload_outlined,
                          color: Colors.red,
                          size: 50,
                        ),
                        Text("Drag n drop files here",
                            style: TextStyle(
                                color: Colors.black54, fontFamily: 'OpenSans')),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 0, 8),
                      height: 30,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        onPressed: () {},
                        textColor: Colors.white,
                        child: Text(
                          'Browse Files',
                          style: TextStyle(fontFamily: 'Open'),
                        ),
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                )),
          ),
        ),
        SizedBox(height: 20)
      ],
    );
  }
}