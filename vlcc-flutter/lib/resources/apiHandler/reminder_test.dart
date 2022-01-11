import 'package:flutter/material.dart';

import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/database/reminder_model.dart';

class ReminderTestDatabase extends StatefulWidget {
  final DatabaseHelper databaseHelper;
  const ReminderTestDatabase({
    Key? key,
    required this.databaseHelper,
  }) : super(key: key);

  @override
  _ReminderTestDatabaseState createState() => _ReminderTestDatabaseState();
}

class _ReminderTestDatabaseState extends State<ReminderTestDatabase>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  final TextEditingController reminder = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: SizedBox(
            height: 250,
            width: 250,
            // elevation: 6,
            // shadowColor: Colors.black54,
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
                    controller: reminder,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        var _ = ReminderModel(
                            title: 'reminder',
                            reminderDateTime: reminder.text.trim());
                        // widget.databaseHelper.insertReminder(reminderModel);
                      },
                      child: Text('Add reminder'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
