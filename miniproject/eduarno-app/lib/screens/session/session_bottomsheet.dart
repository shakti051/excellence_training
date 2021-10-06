import 'dart:async';
import 'dart:io';
import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/Utilities/dimentions.dart';
import 'package:eduarno/screens/session/comment_model.dart';
import 'package:eduarno/screens/session/comment_service.dart';
import 'package:eduarno/screens/session/session_provider.dart';
import 'package:eduarno/screens/session/upload_image_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SessionBottomSheet extends StatefulWidget {
  String requestId;
  final int index;
  SessionBottomSheet({this.requestId, this.index});
  @override
  _SessionBottomSheetState createState() => _SessionBottomSheetState();
}

class _SessionBottomSheetState extends State<SessionBottomSheet> {
  final TextEditingController _commentTextController = TextEditingController();
  File _image;
  UploadImageApi apiImage = UploadImageApi();
  var val;
  bool uploading = false;
  final picker = ImagePicker();
  CommentService api = CommentService();
  CommentModel commentModel;
  bool _apiHit = false;
  var finalUrl;

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  var comment;
  String _filePath;
  File _docFile;
  _sendComment() async {
    comment = await api
        .getComment(
            requestId: widget.requestId,
            comment: _commentTextController.text,
            imageUrl: finalUrl)
        .then((value) {
      commentModel = value;
      _btnController.success();
      _closeBottomSheet();
    });
    return comment;
  }

  void _closeBottomSheet() async {
    Timer(Duration(seconds: 1), () {
      Fluttertoast.showToast(msg: 'Saved', toastLength: Toast.LENGTH_LONG);
      Navigator.pop(context);
    });
  }

// Implementing the image picker
  // Future<void> _openImagePicker() async {
  //   final pickedImage = await picker.getImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     setState(() {
  //       _image = File(pickedImage.path);
  //       print(_image);
  //     });
  //   }
  // }

  Future getFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    setState(() {
      if (result != null) {
        _docFile = File(result.files.single.path);
        _filePath = _docFile.path;
        uploading = true;
        //print("file path>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+file.path);
      }
    });
    try {
      var val = await apiImage.uploadImage(
        file: _docFile,
      );
      finalUrl = val.body;
      setState(() {
        _apiHit = true;
        uploading = false;
      });
      print(finalUrl);
      Fluttertoast.showToast(msg: 'uploaded', toastLength: Toast.LENGTH_LONG);
    } catch (e) {
      print("url error" + e);
    }
  }

  Future getImage() async {
    final image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        uploading = false;
        _image = File(image.path);
      }
    });
    try {
      var val = await apiImage.uploadImage(
        file: _image,
      );
      //  print('value ' + val.body
      finalUrl = val.body;
      setState(() {
        _apiHit = true;
      });
      print(finalUrl);
      Fluttertoast.showToast(msg: 'uploaded', toastLength: Toast.LENGTH_LONG);
    } catch (e) {
      print('url error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: shadowGreen,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 16),
            SvgPicture.asset('assets/line.svg'),
            SizedBox(height: 8),
            Text(
              'Know the answer ?',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: Dimensions.FONT_SIZE_LARGE),
            ),
            RaisedButton(
                color: btnGreen,
                onPressed: () => getFile(), //getImage(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Container(
                  width: 150,
                  child: Row(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.add, color: Colors.white)),
                      Container(
                          margin: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Upload Answer',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.FONT_SIZE_DEFAULT),
                          ))
                    ],
                  ),
                )),
            SizedBox(height: 16),
            uploading
                ? Center(child: CircularProgressIndicator())
                : Visibility(
                    visible: finalUrl == null ? false : true,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: Dimensions.MARGIN_SIZE_DEFAULT),
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50,
                      color: Colors.grey[300],
                      child: finalUrl == null
                          ? Text('click on upload answerselect file')
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                (((finalUrl.toString() != null &&
                                        finalUrl.toString() != '')
                                    ? (finalUrl.toString().contains('.pdf')
                                        ? Icon(
                                            Icons.picture_as_pdf,
                                            color: Colors.red,
                                          )
                                        : (RegExp(r'([a-zA-Z0-9\s_\\.\-\(\):])+(sheet|docx|pdf|document|spreadsheet)$')
                                                .hasMatch(finalUrl.toString())
                                            ? Icon(
                                                CupertinoIcons.doc,
                                                color: Colors.green,
                                              )
                                            : Icon(
                                                Icons.image_outlined,
                                                color: Colors.blue,
                                              )))
                                    : Icon(Icons.attachment))),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child:
                                        Text(finalUrl.toString().substring(51)),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    top: Dimensions.MARGIN_SIZE_DEFAULT,
                    bottom: Dimensions.MARGIN_SIZE_DEFAULT),
                child: Text('Comments (Optional)',
                    style: TextStyle(
                        color: Colors.black87,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: Dimensions.FONT_SIZE_DEFAULT))),
            Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
                    vertical: Dimensions.MARGIN_SIZE_DEFAULT),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: TextFormField(
                    cursorColor: Colors.black38,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        hintText: '  Add comments for Answers'),
                    controller: _commentTextController,
                    //keyboardType: TextInputType.multiline,
                    maxLines: 5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _apiHit
                    ? RoundedLoadingButton(
                        color: Colors.green[400],
                        successColor: kLightGreen,
                        onPressed: () {
                          _sendComment();
                          Provider.of<SessionProvider>(context, listen: false)
                              .setPostedUrl(finalUrl, widget.index);
                        },
                        controller: _btnController,
                        child: Text('Submit',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto',
                                fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                      )
                    : RoundedLoadingButton(
                        color: Colors.green[400],
                        successColor: kLightGreen,
                        // onPressed: () {
                        //   _sendComment();
                        //   Provider.of<SessionProvider>(context,listen: false).updateUrl(finalUrl);
                        // },
                        onPressed: () {},
                        controller: _btnController,
                        child: Text('Submit',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto',
                                fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                      ),

                // Container(
                //     margin: EdgeInsets.only(
                //         right: Dimensions.MARGIN_SIZE_DEFAULT,
                //         top: Dimensions.MARGIN_SIZE_DEFAULT,
                //         bottom: Dimensions.MARGIN_SIZE_DEFAULT),
                //     decoration: BoxDecoration(
                //         border: Border.all(color: kLightGreen, width: 1.0),
                //         borderRadius: BorderRadius.all(Radius.circular(20)),
                //         color: Colors.white),
                //     child: Text("hello"))
              ],
            ),
            SizedBox(height: 20)
          ],
        ));
  }
}
