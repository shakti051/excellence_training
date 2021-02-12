import 'package:feedback/resources/app_colors.dart';
import 'package:feedback/widgets/res_feedback/res_feedback.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

class Clientfeedback extends StatefulWidget {
  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<Clientfeedback> {
  List<int> likesOf = [
    15,
    18,
    90,
    20,
    56,
    78,
  ];

  List<int> dislikesOf = [
    100,
    200,
    300,
    500,
    200,
    23,
  ];

  @override
  Widget build(BuildContext context) {
    final _search = TextEditingController();
    final _title = TextEditingController();
    final _category = TextEditingController();
    final __description = TextEditingController();

    customDialog() {
      return showDialog(
          context: context,
          builder: (BuildContext c) {
            return Dialog(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * .3,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    Row(children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(8, 16, 8, 16),
                          child: Text('Add New Feedback',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Open',
                                color: AppColors.BACKGROUND_COLOR,
                                fontWeight: FontWeight.w700,
                              )))
                    ]),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.fromLTRB(8, 0, 8, 16),
                                child: Text(
                                    'Tell us about your feedback feature or idea that will make our products better ',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.BACKGROUND_COLOR,
                                      fontFamily: 'Open',
                                      fontWeight: FontWeight.w400,
                                    ))),
                          )
                        ]),
                    SizedBox(height: 30),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: TextFormField(
                        controller: _title,
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(3),
                            ),
                          ),
                          labelText: 'Title',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: TextFormField(
                        controller: _category,
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(3),
                            ),
                          ),
                          labelText: 'Category',
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(8),
                        child: TextFormField(
                            controller: __description,
                            maxLines: 5,
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(3),
                                ),
                              ),
                              labelText: 'Description',
                            ))),
                    Container(
                        margin: EdgeInsets.all(8),
                        child: DottedBorder(
                          strokeWidth: 2,
                          dashPattern: [8, 4],
                          borderType: BorderType.Rect,
                          color: Colors.grey,
                          radius: Radius.circular(3),
                          padding: EdgeInsets.all(6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: Container(
                                height: 80,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.cloud_upload_sharp,
                                        color: Colors.grey),
                                    SizedBox(height: 10),
                                    Text(
                                      "Drag and drop files here",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'OpenSans'),
                                    )
                                  ],
                                )),
                          ),
                        )),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: FlatButton(
                              padding: EdgeInsets.all(16),
                              onPressed: () {},
                              child: const Text('Cancel',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.BACKGROUND_COLOR,
                                      fontFamily: 'Open')),
                              color: AppColors.THEME_COLOR,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      color: AppColors.BACKGROUND_COLOR)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: FlatButton(
                              padding: EdgeInsets.all(16),
                              onPressed: () {},
                              child: const Text('Submit',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontFamily: 'Open')),
                              color: AppColors.BACKGROUND_COLOR,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      color: AppColors.BACKGROUND_COLOR)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            );
          });
    }

    return SingleChildScrollView(
      child: Container(
        color: AppColors.THEME_COLOR,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                  elevation: 3,
                  shape: StadiumBorder(
                      side: BorderSide(color: Colors.transparent)),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(3),
                    width: MediaQuery.of(context).size.width * .65,
                    height: 40,
                    child: TextFormField(
                      controller: _search,
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(18.0),
                          ),
                        ),
                        labelText: 'Search',
                        suffixIcon: CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.BACKGROUND_COLOR,
                            child: Icon(Icons.search)),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(16, 16, 0, 16),
                        child: Image.asset('assets/images/alert.png')),
                    Container(
                        margin: EdgeInsets.fromLTRB(8, 16, 8, 16),
                        child: Image.asset('assets/images/msg.png')),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    margin: MediaQuery.of(context).size.width < 1050
                        ? EdgeInsets.fromLTRB(16, 8, 16, 8)
                        : EdgeInsets.all(20),
                    child: Text(
                      'FEEDBACK',
                      style: TextStyle(fontSize: 18, fontFamily: 'Lato'),
                    )),
              ],
            ),
            MediaQuery.of(context).size.width < 1050
                ? HeadingFeedback()
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(16, 0, 4, 0),
                          child: FlatButton(
                            onPressed: () {},
                            child: const Text('All',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontFamily: 'Open')),
                            color: AppColors.BACKGROUND_COLOR,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                          padding: EdgeInsets.all(4),
                          child: FlatButton(
                            onPressed: () {},
                            child: const Text('Anything',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black87,
                                    fontFamily: 'Open')),
                            color: AppColors.THEME_COLOR,
                            hoverColor: AppColors.BACKGROUND_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.black87)),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                          padding: EdgeInsets.all(4),
                          child: FlatButton(
                            onPressed: () {},
                            child: const Text('Features',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black87,
                                    fontFamily: 'Open')),
                            color: AppColors.THEME_COLOR,
                            hoverColor: AppColors.BACKGROUND_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.black87)),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                          padding: EdgeInsets.all(4),
                          child: FlatButton(
                            onPressed: () {},
                            child: const Text('Suggestions',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black87,
                                    fontFamily: 'Open')),
                            color: AppColors.THEME_COLOR,
                            hoverColor: AppColors.BACKGROUND_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.black87)),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                          padding: EdgeInsets.all(4),
                          child: FlatButton(
                            onPressed: () {},
                            child: const Text('Community',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black87,
                                    fontFamily: 'Open')),
                            color: AppColors.THEME_COLOR,
                            hoverColor: AppColors.BACKGROUND_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.black87)),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                          padding: EdgeInsets.all(4),
                          child: FlatButton(
                            onPressed: () {},
                            child: const Text('Bugs',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black87,
                                    fontFamily: 'Open')),
                            color: AppColors.THEME_COLOR,
                            hoverColor: AppColors.BACKGROUND_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.black87)),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                          padding: EdgeInsets.all(4),
                          child: FlatButton(
                            onPressed: () {},
                            child: const Text('Services',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black87,
                                    fontFamily: 'Open')),
                            color: AppColors.THEME_COLOR,
                            hoverColor: AppColors.BACKGROUND_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.black87)),
                          ),
                        ),
                      ),
                    ],
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width < 1050 ? 70 : 100,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  padding: MediaQuery.of(context).size.width < 1050
                      ? EdgeInsets.all(16)
                      : EdgeInsets.all(32),
                  child: RaisedButton.icon(
                    onPressed: () {
                      customDialog();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    label: Text(
                      'Add New',
                      style: TextStyle(
                          color: AppColors.LIGHT_GREEN,
                          fontSize: 15,
                          fontFamily: 'Open'),
                    ),
                    icon: Icon(
                      Icons.add,
                      color: AppColors.LIGHT_GREEN,
                    ),
                    textColor: Colors.white,
                    color: AppColors.BACKGROUND_COLOR,
                  ),
                ),
              ],
            ),
            Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, int index) => ListFeedbackItems(
                    this.likesOf[index], this.dislikesOf[index]),
                itemCount: this.likesOf.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListFeedbackItems extends StatelessWidget {
  String itemName;
  int likes, dislikes;
  ListFeedbackItems(this.likes, this.dislikes);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.THEME_COLOR,
      margin: EdgeInsets.all(7),
      child: Row(children: <Widget>[
        Liked(
          likes: likes,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width < 1050 ? 5 : 10,
        ),
        Dislike(
          dislikes: dislikes,
        ),
        SizedBox(width: MediaQuery.of(context).size.width < 1050 ? 5 : 10),
        Container(
          height: MediaQuery.of(context).size.width < 1050 ? 200 : 125,
          padding: MediaQuery.of(context).size.width < 1050
              ? EdgeInsets.all(8)
              : EdgeInsets.all(16),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.white),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(8, 4, 4, 4),
                    child: MediaQuery.of(context).size.width < 1050
                        ? Text("Custom drag and drop email template\n sender",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))
                        : Text("Custom drag and drop email template sender",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(8, 0, 5, 0),
                    child: FlatButton(
                      onPressed: () {},
                      child: Text('Suggested',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.lightBlueAccent,
                              fontFamily: 'Open')),
                      color: AppColors.LIGHT_BLUE,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.transparent)),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .46,
                    margin: (MediaQuery.of(context).size.width < 1050 ||
                            MediaQuery.of(context).size.width < 650)
                        ? EdgeInsets.fromLTRB(8, 0, 4, 0)
                        : EdgeInsets.fromLTRB(8, 0, 16, 0),
                    child: Text(
                        "Mailchimp like feature to create custom email templates using the drag and drop option along with saving templateds",
                        style: TextStyle(
                          fontFamily: 'Open',
                          fontSize: 12,
                        )),
                  ),
                  //Addmsg Image
                  Image.asset(
                    'assets/images/chat.png',
                    width: MediaQuery.of(context).size.width < 1050
                        ? 30
                        : MediaQuery.of(context).size.width * .03,
                    height: 30,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(likes.toString(),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.BACKGROUND_COLOR)),
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}

class Liked extends StatefulWidget {
  int likes;
  Liked({this.likes});
  @override
  _LikedState createState() => _LikedState(likes: likes);
}

class _LikedState extends State<Liked> {
  int likes;
  bool liked = false;

  void _incrementCounter() {
    setState(() {
      likes++;
    });
  }

  _LikedState({this.likes});
  _pressed() {
    setState(() {
      liked = !liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: Container(
        width: MediaQuery.of(context).size.width * .1,
        height: MediaQuery.of(context).size.width < 1050 ? 200 : 125,
        padding: MediaQuery.of(context).size.width < 1050
            ? EdgeInsets.all(4)
            : EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                _pressed();
                _incrementCounter();
              },
              child: Image(
                image: AssetImage('assets/images/likes.png'),
              ),
            ),
            //  Image.asset('assets/images/likes.png'),
            SizedBox(height: 10),
            Text(likes.toString(),
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.width < 1050 ? 12 : 15,
                    fontFamily: 'Lato',
                    color: AppColors.BACKGROUND_COLOR)),
          ],
        ),
      ),
    );
  }
}

class Dislike extends StatefulWidget {
  int dislikes;
  Dislike({this.dislikes});
  @override
  _DislikeState createState() => _DislikeState(dislikes: dislikes);
}

class _DislikeState extends State<Dislike> {
  int dislikes;
  bool disliked = false;
  _DislikeState({this.dislikes});

  void _decrementCounter() {
    setState(() {
      dislikes--;
    });
  }

  _pressed() {
    setState(() {
      disliked = !disliked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: Container(
        width: MediaQuery.of(context).size.width * .1,
        height: MediaQuery.of(context).size.width < 1050 ? 200 : 125,
        padding: MediaQuery.of(context).size.width < 1050
            ? EdgeInsets.all(4)
            : EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                _pressed();
                _decrementCounter();
              },
              child: Image(
                image: AssetImage('assets/images/dislikes.png'),
              ),
            ),
            //  Image.asset('assets/images/likes.png'),
            SizedBox(height: 10),
            Text(dislikes.toString(),
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.width < 1050 ? 12 : 15,
                    fontFamily: 'Lato',
                    color: AppColors.BACKGROUND_COLOR)),
          ],
        ),
      ),
    );
  }
}
