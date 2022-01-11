import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoDatePicker(
        onDateTimeChanged: (DateTime value) {},
        initialDateTime: DateTime.now(),
        maximumDate: DateTime.now(),
        mode: CupertinoDatePickerMode.date,
      ),
    );
  }
}
