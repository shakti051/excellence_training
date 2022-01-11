// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:vlcc/components/components.dart';
// import 'package:vlcc/database/db_helper.dart';
// import 'package:vlcc/models/center_master_model.dart';
// import 'package:vlcc/resources/app_colors.dart';
// import 'package:vlcc/resources/assets_path.dart';
// import 'package:vlcc/resources/common_strings.dart';
// import 'package:vlcc/resources/dimensions.dart';
// import 'package:provider/provider.dart';

// class Appointments extends StatelessWidget {
//   final CenterMasterDatabase centerMasterDatabase;
//   const Appointments({Key? key, required this.centerMasterDatabase})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
// final databaseProvider = context.watch<DatabaseHelper>();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 32),
//         Text("Services",
//             style: TextStyle(
//                 fontFamily: FontName.frutinger,
//                 fontWeight: FontWeight.w700,
//                 fontSize: FontSize.extraLarge)),
//         SizedBox(height: 24),
//         Column(
//           children: List.generate(
//             databaseProvider.centerMasterDbList.length,
//             (index) => MedicalServices(
//               index: index,
//               serviceMasterDatabase:
//                   databaseProvider.serviceMasterDbList[index],
//               centerMasterDatabase: centerMasterDatabase,
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
