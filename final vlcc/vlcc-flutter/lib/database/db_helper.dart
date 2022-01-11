import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vlcc/models/appointment_list_model.dart';
import 'package:vlcc/models/center_master_model.dart';
import 'package:vlcc/models/service_master_model.dart';
import 'package:vlcc/models/unique_service_model.dart';
import 'package:vlcc/models/vlcc_reminder_model.dart';

class DatabaseHelper extends ChangeNotifier {
  static final DatabaseHelper _singleton = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _singleton;
  }
  DatabaseHelper._internal();

  static Database? _database;

  //**Service master Table**

  final String masterServiceTable = 'service_master';
  final String masterServiceColumnId = 'id';
  final String masterServiceCode = 'service_code';
  final String masterServiceName = 'service_name';
  final String masterServiceCategory = 'service_category';
  final String masterServiceSubCategory1 = 'service_sub_category1';
  final String masterServiceSubCategory2 = 'service_sub_category2';
  final String masterServiceType = 'service_type';
  final String masterServiceAppFor = 'service_app_for';
  final String masterServiceStatus = 'service_status';
  final String masterPopularService = 'popular_center';

  //*Center master table**

  final String centerMasterTable = 'center_master';
  final String centerMasterId = 'id';
  final String centerMasterCode = 'center_code';
  final String centerMasterName = 'center_name';
  final String centerMasterType = 'center_type';
  final String centerMasterCenterPic = 'center_pic';
  final String centerMasterRateList = 'center_ratelist';
  final String centerMasterAddressLine1 = 'address_line1';
  final String centerMasterAddressLine2 = 'address_line2';
  final String centerMasterAddressLine3 = 'address_line3';
  final String centerMasterArea = 'area_name';
  final String centerMasterCity = 'city_name';
  final String centerMasterState = 'state_name';
  final String centerMasterCountry = 'country_name';
  final String centerMasterPhone = 'phone_number';
  final String centerMasterMap = 'center_map';
  final String centerMasterLatitude = 'center_latitude';
  final String centerMasterLongitude = 'center_longitude';
  final String centerMasterStatus = 'center_status';

  //------------------------> Reminder table init <-----------------------------
  final String reminderTable = 'reminder_table';
  final String reminderId = 'id';
  final String reminderAppointmentIndex = 'appointment_index';
  final String reminderScheduledTime = 'time_schedule';
  final String reminderTitle = 'reminder_title';
  final String reminderDescription = 'reminder_description';
  final String reminderSet = 'is_set';
  final String reminderInsertTime = "insert_time";
  final String reminderTriggerTime = "reminder_trigger_time";
  final String reminderAddressLine1 = "address_line1";
  final String reminderAddressLine2 = "address_line2";
  final String reminderType = "appointment_type";
  final String reminderAppointmentDateSecond = "appointment_date_second";
  final String reminderAppointmentId = "appointment_id";

//------------------------> Reminder table init exp <-----------------------------
  final String reminderTableExp = 'reminder_table_exp';
  final String reminderIdExp = 'id';
  final String reminderAppointmentIndexExp = 'appointment_index';
  final String reminderScheduledTimeExp = 'time_schedule';
  final String reminderTitleExp = 'reminder_title';
  final String reminderDescriptionExp = 'reminder_description';
  final String reminderSetExp = 'is_set';
  final String reminderInsertTimeExp = "insert_time";
  final String reminderTriggerTimeExp = "reminder_trigger_time";
  final String reminderAddressLine1Exp = "address_line1";
  final String reminderAddressLine2Exp = "address_line2";
  final String reminderTypeExp = "appointment_type";
  final String reminderAppointmentDateSecondExp = "appointment_date_second";
  final String reminderAppointmentIdExp = "appointment_id";

  //---------------------------> Completes here <-------------------------------

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initializeDatabase();
      return _database;
    }
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = '${dir}vlcc_reminder.db';
    var database = await openDatabase(path,
        version: 1,
        onDowngrade: onDatabaseDowngradeDelete, onCreate: (db, version) {
      db.execute('DROP TABLE IF EXISTS $masterServiceTable');
      db.execute('''
      CREATE TABLE $masterServiceTable (
        $masterServiceColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $masterServiceCode TEXT,
        $masterServiceName TEXT,
        $masterServiceCategory TEXT,
        $masterServiceSubCategory1 TEXT,
        $masterServiceSubCategory2 TEXT,
        $masterServiceType TEXT,
        $masterServiceAppFor TEXT,
        $masterServiceStatus TEXT,
        $masterPopularService TEXT
      )
       ''');

      db.execute('DROP TABLE IF EXISTS $centerMasterTable');
      db.execute('''
      CREATE TABLE $centerMasterTable (
        $centerMasterId INTEGER PRIMARY KEY AUTOINCREMENT,
        $centerMasterCode TEXT,
        $centerMasterName TEXT,
        $centerMasterType TEXT,
        $centerMasterRateList TEXT,
        $centerMasterAddressLine1 TEXT,
        $centerMasterAddressLine2 TEXT,
        $centerMasterAddressLine3 TEXT,
        $centerMasterCenterPic TEXT,
        $centerMasterArea TEXT,
        $centerMasterCity TEXT,
        $centerMasterState TEXT,
        $centerMasterCountry TEXT,
        $centerMasterPhone TEXT,
        $centerMasterMap TEXT,
        $centerMasterLatitude TEXT,
        $centerMasterLongitude TEXT,
        $centerMasterStatus TEXT
      )
       ''');

      db.execute('DROP TABLE IF EXISTS $reminderTable');
      db.execute('''
      CREATE TABLE $reminderTable (
        $reminderId INTEGER PRIMARY KEY AUTOINCREMENT,
        $reminderAppointmentIndex INTEGER NOT NULL,
        $reminderScheduledTime INTEGER,
        $reminderTitle TEXT,
        $reminderDescription TEXT,
        $reminderSet INTEGER NOT NULL,
        $reminderInsertTime INTEGER NOT NULL,
        $reminderTriggerTime INTEGER NOT NULL, 
        $reminderAddressLine1 TEXT,
        $reminderAddressLine2 TEXT,
        $reminderType INTEGER NOT NULL,
        $reminderAppointmentDateSecond INTEGER NOT NULL,
        $reminderAppointmentId INTEGER NOT NULL
      )
      ''');

      db.execute('DROP TABLE IF EXISTS $reminderTableExp');
      db.execute('''
      CREATE TABLE $reminderTableExp (
        $reminderIdExp INTEGER PRIMARY KEY AUTOINCREMENT,
        $reminderAppointmentIndexExp INTEGER NOT NULL,
        $reminderScheduledTimeExp INTEGER,
        $reminderTitleExp TEXT,
        $reminderDescriptionExp TEXT,
        $reminderSetExp INTEGER NOT NULL,
        $reminderInsertTimeExp INTEGER NOT NULL,
        $reminderTriggerTimeExp INTEGER NOT NULL, 
        $reminderAddressLine1Exp TEXT,
        $reminderAddressLine2Exp TEXT,
        $reminderTypeExp INTEGER NOT NULL,
        $reminderAppointmentDateSecondExp INTEGER NOT NULL,
        $reminderAppointmentIdExp INTEGER NOT NULL
      )
      ''');
    });
    return database;
  }

  //reminderTriggerTime ---> time when reminder is triggered in seconds (on time, 15min ago)
  //reminderInsertTime ---> time when reminder is inserted in millisecfromepoch.

  Future<VlccReminderModel> getRemindersQuery(
      {required int appointmentId}) async {
    var db = await database;
    final result = await db!.query(
      reminderTable,
      where: '$reminderAppointmentId = ?',
      whereArgs: [appointmentId],
    );
    var response = result.toList();
    return VlccReminderModel.fromJson(response[0]);
  }

  Future<VlccReminderModel> getRemindersQueryExp(
      {required int appointmentIdExp}) async {
    var db = await database;
    final result = await db!.query(
      reminderTable,
      where: '$reminderAppointmentIdExp = ?',
      whereArgs: [appointmentIdExp],
    );
    var response = result.toList();
    return VlccReminderModel.fromJson(response[0]);
  }

  List<UniqueServiceModel> _uniqueServiceListFilter = [];
  List<UniqueServiceModel> get uniqueServiceListFilter =>
      _uniqueServiceListFilter;
  set uniqueServiceListFilter(List<UniqueServiceModel> uniqueFilter) {
    _uniqueServiceListFilter = uniqueFilter;
    notifyListeners();
  }

  final List<UniqueServiceModel> _uniqueServiceList = [];
  List<UniqueServiceModel> get uniqueServiceList => _uniqueServiceList;

  void getUniqueSpeciality() async {
    var db = await database;
    // final response = await db!.query(masterServiceTable,
    //     distinct: false, groupBy: masterServiceCategory);
    final response = await db!.rawQuery(
        '''SELECT COUNT($masterServiceCategory) as COUNT, $masterServiceCategory
      FROM $masterServiceTable
      GROUP BY $masterServiceCategory;''');
    var responseList = response.toList();
    _uniqueServiceList.clear();
    for (var element in responseList) {
      _uniqueServiceList.add(UniqueServiceModel.fromJson(element));
    }
    notifyListeners();
  }

  Future<void> updateReminder(
      {required VlccReminderModel reminderModel,
      required int appointmentId}) async {
    var db = await database;
    var result = await db!.update(
      reminderTable,
      reminderModel.toJson(),
      where: '$reminderId = ?',
      whereArgs: [appointmentId],
    );
    log(result.toString(), name: 'Updated');
    notifyListeners();
  }

  Future<void> updateReminderExp(
      {required VlccReminderModel reminderModel,
      required int appointmentIdExp}) async {
    var db = await database;
    var result = await db!.update(
      reminderTable,
      reminderModel.toJson(),
      where: '$reminderIdExp = ?',
      whereArgs: [appointmentIdExp],
    );
    log(result.toString(), name: 'Updated');
    notifyListeners();
  }

  Future<void> insertReminder(
      {required VlccReminderModel reminderModel}) async {
    var db = await database;
    var result = await db!.insert(reminderTable, reminderModel.toJson());
    log('$result', name: 'Insert Reminder');
  }

  Future<void> insertReminderExp(
      {required VlccReminderModel reminderModel}) async {
    var db = await database;
    var result = await db!.insert(reminderTableExp, reminderModel.toJson());
    log('$result', name: 'Insert Reminder');
  }

  List<ServiceMasterDatabase> _popularServices = [];
  List<ServiceMasterDatabase> get popularServices => _popularServices;
  void setPopularService() {
    _popularServices = _serviceMasterDbList
        .where(
            (service) => service.popularService.toLowerCase().contains('yes'))
        .toList();
    notifyListeners();
  }

  int _serviceMasterCount = 0;
  int get serviceMasterCountGet => _serviceMasterCount;
  set serviceMasterCountSet(int count) {
    _serviceMasterCount = count;
    notifyListeners();
  }

  int _centerMasterCount = 0;
  int get centerMasterCountGet => _centerMasterCount;
  set centerMasterCountSet(int count) {
    _centerMasterCount = count;
    notifyListeners();
  }

  void insertService(ServiceMasterDatabase serviceInfo) async {
    var db = await database;
    var result = await db!.insert(masterServiceTable, serviceInfo.toJson());
    // log('$result');
    _serviceMasterCount++;
    notifyListeners();
  }

  // void insertReminder(AppointmentDetail serviceInfo) async {
  //   var db = await database;
  //   var result = await db!.insert(appointTable, serviceInfo.toJson());
  //   log('$result');
  //   notifyListeners();
  // }

  void insertCenter(CenterMasterDatabase centerInfo) async {
    var db = await database;
    var result = await db!.insert(centerMasterTable, centerInfo.toJson());
    // log('$result');
    _centerMasterCount++;
    notifyListeners();
  }

  List<ServiceMasterDatabase> _serviceMasterDbList = [];
  List<ServiceMasterDatabase> get serviceMasterDbList => _serviceMasterDbList;
  set serviceMasterDbList(List<ServiceMasterDatabase> value) {
    _serviceMasterDbList = value;
    notifyListeners();
  }

  List<AppointmentDetail> _serviceReminderDbList = [];
  List<AppointmentDetail> get serviceReminderDbList => _serviceReminderDbList;
  set serviceReminderDbList(List<AppointmentDetail> value) {
    _serviceReminderDbList = value;
    notifyListeners();
  }

  Future<int> deleteReminder({required int appointmentId}) async {
    var db = await database;
    return await db!.delete(
      reminderTable,
      where: '$reminderAppointmentId = ?',
      whereArgs: [appointmentId],
    );
  }

  Future<int> deleteReminderExp({required int appointmentIdExp}) async {
    var db = await database;
    return await db!.delete(
      reminderTableExp,
      where: '$reminderAppointmentIdExp = ?',
      whereArgs: [appointmentIdExp],
    );
  }

  // Future<int> editReminder(AppointmentDetail? appointmentDetail) async {
  //   var db = await database;
  //   return await db!.update(appointTable,
  //   appointmentDetail.appointmentId.toString(),
  //   );
  // }

  List<ServiceMasterDatabase> _serviceFilterList = [];
  List<ServiceMasterDatabase> get serviceFilterList => _serviceFilterList;
  set serviceFilterList(List<ServiceMasterDatabase> value) {
    _serviceFilterList = value;
    notifyListeners();
  }

  List<CenterMasterDatabase> _centerMasterDbList = [];
  List<CenterMasterDatabase> get centerMasterDbList => _centerMasterDbList;
  set centerMasterDbList(List<CenterMasterDatabase> value) {
    _centerMasterDbList = value;
    notifyListeners();
  }

  List<CenterMasterDatabase> _centerMasterDbFilterList1 = [];
  List<ServiceMasterDatabase> _serviceMasterDbFilterList1 = [];
  List<CenterMasterDatabase> get centerMasterDbFilterList1 =>
      _centerMasterDbFilterList1;
  List<ServiceMasterDatabase> get serviceMasterDbFilterList1 =>
      _serviceMasterDbFilterList1;
  set centerMasterDbFilterList1(List<CenterMasterDatabase> value) {
    _centerMasterDbFilterList1 = value;
    notifyListeners();
  }

  List<CenterMasterDatabase> _centerMasterFilterList = [];
  List<CenterMasterDatabase> get centerMasterFilterList =>
      _centerMasterFilterList;
  set centerMasterFilterList(List<CenterMasterDatabase> value) {
    _centerMasterFilterList = value;
    notifyListeners();
  }

  //----------------------------------> Get reminders <---------------------------------
  List<VlccReminderModel> _vlccReminderList = [];
  List<VlccReminderModel> get vlccReminderList => _vlccReminderList;
  set vlccReminderList(List<VlccReminderModel> val) {
    _vlccReminderList = val;
    notifyListeners();
  }

  Future<List<VlccReminderModel>> getReminders() async {
    List<VlccReminderModel> _reminderList = [];
    var db = await database;
    var result = await db!.query(reminderTable);
    for (var reminder in result) {
      var reminderInfo = VlccReminderModel.fromJson(reminder);
      _reminderList.add(reminderInfo);
      notifyListeners();
    }
    _vlccReminderList = _reminderList;
    return _reminderList;
  }

//----------------------------------> Get Services <---------------------------------
  Future<List<ServiceMasterDatabase>> getServices() async {
    List<ServiceMasterDatabase> _serviceList = [];
    var db = await database;
    var result = await db!.query(masterServiceTable);
    for (var service in result) {
      var serviceInfo = ServiceMasterDatabase.fromJson(service);
      _serviceList.add(serviceInfo);
      notifyListeners();
    }
    _serviceMasterDbList = _serviceList;
    return _serviceList;
  }

  //----------------------------------> Get Centers <---------------------------------

  Future<List<CenterMasterDatabase>> getCenters() async {
    List<CenterMasterDatabase> _centerList = [];
    var db = await database;
    var result = await db!.query(centerMasterTable);
    for (var center in result) {
      var centerInfo = CenterMasterDatabase.fromJson(center);
      _centerList.add(centerInfo);
      notifyListeners();
    }
    _centerMasterDbList = _centerList;
    return _centerList;
  }

  //----------------------------------> Remove Reminders <---------------------------------

  Future<int> removeReminder(int? id) async {
    var db = await database;
    var res = await db!.delete(masterServiceTable,
        where: '$masterServiceColumnId = ?', whereArgs: [id]);
    log(res.toString());
    return res;
  }

  Future<void> removeDatabase() async {
    var db = await database;
    var dir = await getDatabasesPath();
    var path = '${dir}vlcc_reminder.db';
    // var delMaster = await db!.execute('DELETE FROM $masterServiceTable');
    // var delCenter = await db.execute('DELETE FROM $centerMasterTable');
    var _ = await db!.delete(masterServiceTable);
    var res2 = await db.delete(centerMasterTable);
    var res3 = await db.delete(reminderTable);
    _database = null;
    await db.close();
    // log, name: 'Master table drop');

// Delete the database
    await deleteDatabase(path);
  }
}
