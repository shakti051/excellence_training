import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<dynamic> kShowOptions(BuildContext context, Widget child) {
  return showMaterialModalBottomSheet(
    backgroundColor: const Color(0x00000000),
    context: context,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: child),
    ),
  );
}

class BottomSheetOptionTile extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;
  final void Function() onTap;

  const BottomSheetOptionTile(
      {this.color = const Color(0xff4a4a4a),
      this.title,
      this.icon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          icon,
          color: color,
          size: 30,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class SelectOptionBottomSheet extends StatelessWidget {
  final List<String> options;
  final void Function(String) onSelected;
  final String title;

  const SelectOptionBottomSheet(
      {Key key, this.onSelected, @required this.options, this.title = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.78),
      child: options == null || options.isEmpty
          ? ListTile(
              onTap: () => Navigator.pop(context),
              title: Text(
                'No Item Found!',
                style: TextStyle(color: Colors.red),
              ),
            )
          : ListView(
              shrinkWrap: true,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(left: 15.0, bottom: 10),
                //   child: Text(
                //     title,
                //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                //   ),
                // ),
                for (String option in options)
                  ListTile(
                    onTap: () {
                      onSelected(option);
                    },
                    title: Text(option),
                  )
              ],
            ),
    );
  }
}
