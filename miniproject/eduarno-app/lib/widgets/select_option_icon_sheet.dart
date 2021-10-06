// import 'package:flutter/material.dart';
// class SelectOptionIconBottomSheet extends StatelessWidget {
//   final List<String> options;
//   final void Function(String) onSelected;
//   final String title;
//
//   const SelectOptionIconBottomSheet(
//       {Key key, this.onSelected, @required this.options, this.title = ""})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints:
//       BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.78),
//       child: options == null || options.isEmpty
//           ? ListTile(
//         onTap: () => Navigator.pop(context),
//         title: Text(
//           'No Item Found!',
//           style: TextStyle(color: Colors.red),
//         ),
//       )
//           : ListView(
//         shrinkWrap: true,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 15.0, bottom: 10),
//             child: Text(
//               title,
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//           ),
//           for (String option in options)
//             ListTile(
//               leading: Icon(
//                 icon,
//                 color: color,
//                 size: 30,
//               ),
//               onTap: () => onSelected(option),
//               title: Text(option),
//             )
//         ],
//       ),
//     );
//   }
// }
