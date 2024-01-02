import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initildb();
      return _db!;
    } else {
      return _db!;
    }
  }

  Future<Database> initildb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "todo.db");
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);

    return mydb;
  }

  Future<void> _onCreate(Database db, int num) async {
    await db.execute(
      'CREATE TABLE "tasks" ("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT , "title" TEXT NOT NULL, "status" TEXT,"")',
    );
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  Future<List<Map<String, Object?>>> readData({required String query}) async {
    Database? database = await db;
    List<Map<String, Object?>> response = await database.rawQuery(query);
    return response;
  }

  Future<int> inserData({required String query}) async {
    Database? database = await db;
    int response = await database.rawInsert(query);
    return response;
  }

  Future<int> deleteData({required String query}) async {
    Database? database = await db;
    int response = await database.rawDelete(query);
    return response;
  }

  Future<int> updateData({required String query}) async {
    Database? database = await db;
    int response = await database.rawUpdate(query);
    return response;
  }

  Future<void> deleteCurrentDatabase() async {
    String databasePath =
        await getDatabasesPath(); // نجيب مسار اللي نخزن فيها الداتا بيز
    String path = join(databasePath, "todo.db");
    deleteDatabase(path);
  }
}
