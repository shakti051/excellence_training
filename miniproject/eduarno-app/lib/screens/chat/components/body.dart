import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:eduarno/screens/chat/components/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../Utilities/constants.dart';
import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<AnimatedFloatingActionButtonState> fabKey = GlobalKey();
  final ImagePicker _imagePicker = ImagePicker();
  List<XFile> _imageFileList;
  List<String> _imagePath;

  // set _imageFile(XFile value) {
  //   _imageFileList = value == null ? null : [value];
  // }

  // Future<void> documentPicker() async {
  //   FilePickerResult file =
  //       await FilePicker.platform.pickFiles(type: FileType.any);
  //   print(file);
  // }

  Future<void> imagePickGallery() async {
    _imageFileList = await _imagePicker.pickMultiImage();
    _imageFileList.forEach((element) {
      _imagePath.add(element.path);
    });
    print('List of images from gallery $_imageFileList');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatMessageNotifier>(builder: (context, data, child) {
      final chatNotifier = context.watch<ChatMessageNotifier>();
      return Scaffold(
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: chatNotifier.isActive
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    attachDocument(
                        text: "Image",
                        assetPath: 'assets/ImageIcon.svg',
                        onPress: imagePickGallery()),
                    attachDocument(
                      text: "Document",
                      assetPath: 'assets/Document.svg',
                      // onPress: documentPicker(),
                    ),
                  ],
                ),
              )
            // ? AnimatedFloatingActionButton(
            //     fabButtons: [
            //       // attachDocument(
            //       //     text: "Image", assetPath: 'assets/ImageIcon.svg'),
            //       // attachDocument(
            //       //     text: "Document", assetPath: 'assets/Document.svg'),
            //       add(),
            //     ],
            //     animatedIconData: AnimatedIcons.menu_arrow,
            //   )
            : null,
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 34),
              child: ListView.builder(
                  itemCount: demoChat.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Message(
                      message: demoChat[index],
                    );
                  }),
            )),
            ChatInputField(),
          ],
        ),
      );
    });
  }

  Widget add() {
    return FloatActionButtonText(
      onPressed: () {
        fabKey.currentState.animate();
      },
      icon: Icons.add,
      text: "Ativar/Desativar Âncora",
      textLeft: -215,
    );
  }

  Row attachDocument({String text, String assetPath, var onPress}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(
            text,
            style: TextStyle(
                color: kChatColor, fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            mini: true,
            onPressed: () {
              onPress();
              // fabKey.currentState.animate();
            },
            child: SvgPicture.asset(assetPath),
            backgroundColor: Colors.white,
            elevation: 5,
          ),
        ),
      ],
    );
  }
}
