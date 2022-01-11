import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vlcc/models/appointment_list_model.dart';

class ReminderDbHelper {
  static final ReminderDbHelper instance = ReminderDbHelper._instance();

  static Database? _db;

  ReminderDbHelper._instance();

  String appointTable = 'appoint_table';
  String columnIDAppoint = 'id_appoint';
  String colserviceName = 'serviceName';
  String colDate = 'date';
  String coladdress = 'address';
  String colStatus = 'status';

  /*
  This is how our note table will look
  id_appoint | serviceName | Date | address | Status
  0     ""      ""      ""         0
  1     ""      ""      ""         1
  */

  Future<Database?> get db async {
    _db ??= await _initDb();
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}reminder_list.db';
    final appointListDB =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return appointListDB;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $appointTable($columnIDAppoint INTEGER PRIMARY KEY AUTOINCREMENT, $colserviceName TEXT, $colDate TEXT, $coladdress TEXT, $colStatus INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getAppointMapList() async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> result = await db!.query(appointTable);
    return result;
  }

  Future<List<AppointmentListModel>> getAppointList() async {
    final List<Map<String, dynamic>> appointMapList = await getAppointMapList();

    final List<AppointmentListModel> appointList = [];

    for (var appointMap in appointMapList) {
      appointList.add(appointmentListModelFromJson(appointMap.keys.toString()));
    }
    // appointList.sort((appointA, apointB) => appointA.date!.compareTo(apointB.date!));

    return appointList;
  }

  // Future<int> insertAppoint(AppointmentListModel appoint) async{
  // Database? db = await this.db;
  // final int result = await db!.insert(
  //   appointTable,
  //   appoint.toMap(),
  // );
  // return result;
  // }

// Future<int> updateNote(Note note) async{
//   Database? db = await this.db;
//   final int result = await db!.update(
//     appointTable,
//     note.toMap(),
//     where: '$colid_appoint = ?',
//     whereArgs: [note.id_appoint],
//   );
//   return result;
// }

// Future<int> deleteNote(int id_appoint) async{
//   Database? db = await this.db;
//   final int result = await db!.delete(
//     appointTable,
//     where: '$colid_appoint = ?',
//     whereArgs: [id_appoint],
//   );
//   return result;
//   }

}
