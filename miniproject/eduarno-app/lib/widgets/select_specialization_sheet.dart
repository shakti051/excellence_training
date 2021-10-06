import 'package:eduarno/repo/bloc/assessment/model/specialization.dart';
import 'package:flutter/material.dart';

class SelectSpecializationBottomSheet extends StatefulWidget {
  final List<Specialization> options;
  final void Function(String, String) onSelected;
  final String title;
  List<Specialization> skillsToShow;

  SelectSpecializationBottomSheet(
      {Key key,
      this.onSelected,
      @required this.options,
      this.title = "Specialisation",
      this.skillsToShow})
      : super(key: key);

  @override
  _SelectSpecializationBottomSheetState createState() =>
      _SelectSpecializationBottomSheetState(skillsToShow: skillsToShow);
}

class _SelectSpecializationBottomSheetState
    extends State<SelectSpecializationBottomSheet> {
  List<Specialization> skillsToShow;

  _SelectSpecializationBottomSheetState({this.skillsToShow});

  @override
  void initState() {
    skillsToShow = widget.options;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.78,
          minHeight: MediaQuery.of(context).size.height * 0.78),
      child: widget.options == null || widget.options.isEmpty
          ? ListTile(
              onTap: () => Navigator.pop(context),
              title: Text(
                'No Item Found!',
                style: TextStyle(color: Colors.red),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  _searchBar(),
                  if (skillsToShow.length == 0) ...[
                    ListTile(
                      title: Text(
                          "Sorry but the specialisation you are looking for is not in our system. We will notify you once it will be added."),
                    )
                  ] else ...[
                    for (Specialization option in skillsToShow) ...[
                      ListTile(
                        onTap: () => widget.onSelected(
                            option.specialisation, option.specialisationId),
                        title: Text(option.specialisation),
                      )
                    ],
                    SizedBox(
                      height: 40,
                    )
                  ],
                ],
              ),
            ),
    );
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextField(
        decoration: InputDecoration(hintText: 'Search specialisation...'),
        onChanged: (text) {
          text = text.toLowerCase();
          print('Search query - $text');
          setState(() {
            skillsToShow = widget.options.where((skill) {
              var specialisationName = skill.specialisation.toLowerCase();
              return specialisationName.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  // _listItem() {
  //   return  ListView(
  //           shrinkWrap: true,
  //           children: [
  //             for (Specialization option in skillsToShow) ...[
  //               ListTile(
  //                 onTap: () => widget.onSelected(
  //                     option.specialisation, option.specialisationId),
  //                 title: Text(option.specialisation),
  //               )
  //             ]
  //           ],
  //         );
  // }
}
