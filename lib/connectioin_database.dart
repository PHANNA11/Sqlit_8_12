import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqlit8_12/database_field.dart';
import 'package:sqlit8_12/user_model.dart';

class DBConnection {
  Future<Database> initializeDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'uerDbs.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE $tblName($fId INTEGER PRIMARY KEY, $fName TEXT, $fAge INTEGER, $fprofile TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertData(User user) async {
    final db = await initializeDatabase();
    await db.insert(tblName, user.toJsonData());
    print('Insert Data success');
  }

  Future<List<User>> readData() async {
    final db = await initializeDatabase();
    final List<Map<String, dynamic>> queryResult = await db.query(tblName);
    return queryResult.map((e) => User.fromJsonData(e)).toList();
  }

  Future<void> deleteData(int id) async {
    final db = await initializeDatabase();
    await db.delete(tblName, where: '$fId=?', whereArgs: [id]);
  }

  Future<void> updateData(User user) async {
    final db = await initializeDatabase();
    await db.update(tblName, user.toJsonData(),
        where: '$fId=?', whereArgs: [user.id]);
  }
}

//object-relational mapping (ORM)