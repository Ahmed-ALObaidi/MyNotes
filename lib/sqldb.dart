import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
class SqlDb{
  static Database? _db ;
  static List? note = [];

  static initial() async {
    String DbPath = await getDatabasesPath();
    String Dbpathname = join(DbPath,'ahmed.db');
    _db = await openDatabase(Dbpathname , onCreate: _onCreate , version: 10 , onUpgrade: _onUpgrade);
    readData();
  }
  static _onUpgrade(Database db , int oldversion , int newversion) async{
    print('onUpgrade==============================================================');
  }
  static _onCreate(Database db , int version) async{
    Batch batch = db.batch();
    batch.execute('''
    CREATE TABLE notes(
    'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'note' TEXT NOT NULL,
    'title' TEXT NOT NULL,
    'color' TEXT NOT NULL
     )
  ''');
    batch.execute('''
    CREATE TABLE books(
    'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'note' TEXT NOT NULL,
    'title' TEXT NOT NULL,
    'color' TEXT NOT NULL
     )
  ''');
    await batch.commit();
    print('onCreate==============================================================');
  }

  static readData() async {
    note = [];
    note = await _db!.rawQuery("SELECT * FROM 'notes' ");
  }
  static deleteData(String sql) async {
    await _db!.rawDelete(sql);
    readData();
  }
  static deleteallmydatabase() async{
    String DbPath = await getDatabasesPath();
    String Dbpathname = join(DbPath,'ahmed.db');
    await deleteDatabase(Dbpathname);
  }
  static updateData(String sql) async {
   await _db!.rawUpdate(sql);
   readData();
  }
  static insertData(String sql) async {
    await _db!.rawInsert(sql);
    readData();
  }

  // static read(String table) async {
  //   var respose = await _db!.query(table);
  //   return respose;
  // }
  // static delete(String table , String? mywhere ) async {
  //   var respose = await _db!.delete(table , where: mywhere);
  //   return respose;
  // }
  // static update(String table,Map<String,Object?> values , String? mywhere , ) async {
  //   var respose = await _db!.update(table, values , where: mywhere );
  //   return respose;
  // }
  // static insert(String table ,  Map<String, Object?> values) async {
  //   var respose = await _db!.insert(table , values);
  //   return respose;
  // }


}

