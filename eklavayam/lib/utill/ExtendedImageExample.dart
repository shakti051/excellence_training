import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:image_editor/image_editor.dart' hide ImageSource;
import 'package:image_picker/image_picker.dart';


class ExtendedImageExample extends StatefulWidget {
  @override
  _ExtendedImageExampleState createState() => _ExtendedImageExampleState();
}

class _ExtendedImageExampleState extends State<ExtendedImageExample> {
  final GlobalKey<ExtendedImageEditorState> editorKey = GlobalKey<ExtendedImageEditorState>();

  ImageProvider provider;

  @override
  void initState() {
    super.initState();
   // provider = ExtendedExactAssetImageProvider(R.ASSETS_HAVE_EXIF_3_JPG);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Use extended_image library'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: _pick,
            ),
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () async {
                await crop();
              },
            ),
          ],
        ),
        body: Container(
          height: double.infinity,
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: buildImage(),
              ),
              Expanded(
                child: SliderTheme(
                  data: const SliderThemeData(
                    showValueIndicator: ShowValueIndicator.always,
                  ),
                  child: Column(
                    children: <Widget>[
                      _buildSat(),
                      _buildBrightness(),
                      _buildCon(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildFunctions());
  }

  Widget buildImage() {
    return ExtendedImage.asset(
      "assets/images/chetan.jpg",
      height: 400,
      width: 400,
      extendedImageEditorKey: editorKey,
      mode: ExtendedImageMode.editor,
      fit: BoxFit.contain,
      initEditorConfigHandler: (ExtendedImageState state) {
        return EditorConfig(
          maxScale: 8.0,
          cropRectPadding: const EdgeInsets.all(20.0),
          hitTestSize: 20.0,
          cropAspectRatio: 2 / 1,
        );
      },
    );
  }

  Widget _buildFunctions() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.flip),
          title: const Text('Flip'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.rotate_left),
          title: const Text('Rotate left'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.rotate_right),
          title: const Text('Rotate right'),
        ),
      ],
      onTap: (int index) {
        switch (index) {
          case 0:
            flip();
            break;
          case 1:
            rotate(false);
            break;
          case 2:
            rotate(true);
            break;
        }
      },
      currentIndex: 0,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).primaryColor,
    );
  }

  Future<void> crop([bool test = false]) async {
    final ExtendedImageEditorState state = editorKey.currentState;
    final Rect rect = state.getCropRect();
    final EditActionDetails action = state.editAction;
    final double radian = action.rotateAngle;

    final bool flipHorizontal = action.flipY;
    final bool flipVertical = action.flipX;
    // final img = await getImageFromEditorKey(editorKey);
    final Uint8List img = state.rawImageData;

    final ImageEditorOption option = ImageEditorOption();

    option.addOption(ClipOption.fromRect(rect));
    option.addOption(
        FlipOption(horizontal: flipHorizontal, vertical: flipVertical));
    if (action.hasRotateAngle) {
      option.addOption(RotateOption(radian.toInt()));
    }

    option.addOption(ColorOption.saturation(sat));
    option.addOption(ColorOption.brightness(bright));
    option.addOption(ColorOption.contrast(con));

    option.outputFormat = const OutputFormat.png(88);

    print(const JsonEncoder.withIndent('  ').convert(option.toJson()));

    final DateTime start = DateTime.now();
    final Uint8List result = await ImageEditor.editImage(
      image: img,
      imageEditorOption: option,
    );

    print('result.length = ${result.length}');

    final Duration diff = DateTime.now().difference(start);

    print('image_editor time : $diff');
   // showToast('handle duration: $diff', duration: const Duration(seconds: 5), dismissOtherToast: true);

    showPreviewDialog(result);
  }

  void flip() {
    editorKey.currentState.flip();
  }

  void rotate(bool right) {
    editorKey.currentState.rotate(right: right);
  }

  void showPreviewDialog(Uint8List image) {
    showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          color: Colors.grey.withOpacity(0.5),
          child: Center(
            child: SizedBox.fromSize(
              size: const Size.square(200),
              child: Container(
                child: Image.memory(image),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pick() async {
    final PickedFile result = await ImagePicker().getImage(source: ImageSource.camera);
    if (result != null) {
      print(result.path);
      provider = ExtendedFileImageProvider(File(result.path));
      setState(() {});
    }
  }

  double sat = 1;
  double bright = 1;
  double con = 1;

  Widget _buildSat() {
    return Slider(
      label: 'sat : ${sat.toStringAsFixed(2)}',
      onChanged: (double value) {
        setState(() {
          sat = value;
        });
      },
      value: sat,
      min: 0,
      max: 2,
    );
  }

  Widget _buildBrightness() {
    return Slider(
      label: 'brightness : ${bright.toStringAsFixed(2)}',
      onChanged: (double value) {
        setState(() {
          bright = value;
        });
      },
      value: bright,
      min: 0,
      max: 2,
    );
  }

  Widget _buildCon() {
    return Slider(
      label: 'con : ${con.toStringAsFixed(2)}',
      onChanged: (double value) {
        setState(() {
          con = value;
        });
      },
      value: con,
      min: 0,
      max: 4,
    );
  }
}