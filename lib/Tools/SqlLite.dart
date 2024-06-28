import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfLite {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'abdulaziz.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("onUpgrade =====================================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE "todos" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "id_In_Server" TEXT NOT NULL,
    "todo" TEXT NOT NULL,
    "completed" TEXT NOT NULL,
    "Todo_Priority" TEXT NOT NULL,
    "Todo_Date" TEXT NOT NULL,
    "Todo_Time" TEXT NOT NULL

    )''');
    print(" onCreate =====================================");
  }

//   _onCreate(Database db, int version) async {
//     await db.execute('''
//   CREATE TABLE "notes" (
//     "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
//     "note" TEXT NOT NULL
//   )
//  ''');
//     print(" onCreate =====================================");
//   }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  // Future<void> dropTable() async {
  //   await mydb.execute(
  //     'DROP TABLE IF EXISTS todos',
  //   );
  // }

  Future<void> DropTableAndCreateNewOne() async {
    //here we get the Database object by calling the openDatabase method
    //which receives the path and onCreate function and all the good stuff
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'abdulaziz.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);

    // _db?.delete("todos");
    //here we execute a query to drop the table if exists which is called "tableName"
    //and could be given as method's input parameter too
    await mydb.execute("DROP TABLE IF EXISTS todos");
    //and finally here we recreate our beloved "tableName" again which needs
    //some columns initialization
    await mydb.execute('''CREATE TABLE "todos" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "id_In_Server" TEXT NOT NULL,
    "todo" TEXT NOT NULL,
    "completed" TEXT NOT NULL,
    "Todo_Priority" TEXT NOT NULL,
    "Todo_Date" TEXT NOT NULL,
    "Todo_Time" TEXT NOT NULL
    )''');
    print("DropTableAndCreateNewOne");
  }
// SELECT
// DELETE
// UPDATE
// INSERT
}
