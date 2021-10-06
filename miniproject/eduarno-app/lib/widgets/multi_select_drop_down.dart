import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo/bloc/assessment/model/topic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class SelectMultiOption extends StatefulWidget {
  final List<Topic> list;
  final void Function(List<Map<String, dynamic>>) onItemsSelected;

  const SelectMultiOption({
    Key key,
    this.list,
    this.onItemsSelected,
  }) : super(key: key);

  @override
  _SelectMultiOptionState createState() => _SelectMultiOptionState();
}

class _SelectMultiOptionState extends State<SelectMultiOption> {
  // final Tax _tax = Tax();
  String item;
  bool isLoaded = false;
  final _multiSelectKey = GlobalKey<FormFieldState>();
  List<Map<String, dynamic>> _selectedItem = [];
  List<String> _selectedItemId = [];

  @override
  void initState() {
    isLoaded = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        // isLoaded ?
        Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Color(0xffF6F7FA),
                shape: BoxShape.rectangle,
                // border: Border.no,
                borderRadius: BorderRadius.circular(10)),
            child: MultiSelectBottomSheetField<Topic>(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border(
                      top: BorderSide.none,
                      left: BorderSide.none,
                      right: BorderSide.none,
                      bottom: BorderSide.none),
                  borderRadius: BorderRadius.circular(10)),
              key: _multiSelectKey,
              initialChildSize: 0.5,
              maxChildSize: 1,
              // initialValue: widget.list,
              buttonIcon: Icon(CupertinoIcons.sort_down),
              buttonText: Text(
                'Topic',
                style: TextStyle(
                  color: Color(0xff9D9FA0),
                  fontWeight: FontWeight.w400,
                ),
              ),
              cancelText: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
              confirmText:
                  Text('Ok', style: TextStyle(color: Color(0xff41C36C))),
              items: widget.list
                  .map((topic) =>
                      MultiSelectItem<Topic>(topic, '${topic.topic}'))
                  .toList(),
              searchable: true,
              onConfirm: (values) {
                List<Topic> list = [];
                list.clear();
                setState(() {
                  _selectedItemId = values.map((e) => e.id).toList();
                  if (values.isNotEmpty) {
                    list = values.map((e) => e).toList();
                  } else {
                    list.clear();
                  }
                  _selectedItem.clear();
                  for (Topic topic in list) {
                    var data = {'user_topic': topic.topic};
                    _selectedItem.add(data);
                  }
                });
                widget.onItemsSelected(_selectedItem);
                _multiSelectKey.currentState.validate();
              },
              // checkColor: kPrimaryGreenColor,
              selectedColor: kPrimaryGreenColor,
              chipDisplay: MultiSelectChipDisplay(
                textStyle: TextStyle(color: Colors.white),
                chipColor: Color(0xff41C36C),
                onTap: (item) {
                  setState(() {
                    for (String item1 in _selectedItemId) {
                      if (item1 == item.topicId) {
                        _selectedItem.remove(item);
                        _selectedItemId.remove(item1);
                      }
                    }
                    _selectedItem.remove(item);
                  });
                  _multiSelectKey.currentState.validate();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_multiselect/flutter_multiselect.dart';

// class SelectMultiOption extends StatelessWidget {
//   const SelectMultiOption({ Key key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MultiSelect(
//       dataSource: [],
      
//     );
//   }
// }
