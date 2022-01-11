import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/database/reminder_model.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/apiHandler/reminder_test.dart';

class TestApiCall extends StatefulWidget {
  const TestApiCall({Key? key}) : super(key: key);

  @override
  _TestApiCallState createState() => _TestApiCallState();
}

class _TestApiCallState extends State<TestApiCall> {
  final Services _services = Services();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<ReminderModel>? _reminders;
  int count = 0;

  // void postCall() {
  //   var body = {
  //     'login_mobile': '9811641705',
  //     'device_id': '00000000-89ABCDEF-01234567-89ABCDEF',
  //   };
  //   _services
  //       .callApi(body, '/api/api_client_signin.php?request=login_otp')
  //       .then((value) {
  //     var testVal = value;
  //     log('$testVal', name: 'Test Value');
  //     final otpModel = otpModelFromJson(testVal);
  //     log(otpModel.loginInfo.deviceId, name: 'Device id');
  //   });
  // }

  @override
  void initState() {
    _databaseHelper.initializeDatabase().then((value) {
      log('Database Initialized');
      // loadReminders();
      // count++;
    });
    super.initState();
    // postCall();
  }

  // @override
  // void didChangeDependencies() {
  //   if (count > 1) loadReminders();
  //   super.didChangeDependencies();
  // }

  // void loadReminders() {
  //   _databaseHelper.getReminders().then((value) {
  //     _reminders = value;
  //   });
  //   if (mounted) setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: ElevatedButton(
            onPressed: () {
              showDialog(
                barrierColor: Colors.black45,
                context: context,
                builder: (_) => ReminderTestDatabase(
                  databaseHelper: _databaseHelper,
                ),
              );
            },
            child: Text('Add reminder')),
        body: ListView(
          children: List.generate(
            _reminders!.length,
            (index) => InkWell(
                onLongPress: () {
                  _databaseHelper
                      .removeReminder(_reminders![index].id)
                      .then((value) {
                    setState(() {
                      log('Deleted');
                    });
                  });
                },
                child: Text(_reminders![index].reminderDateTime)),
          ),
        ));
  }
}
