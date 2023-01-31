import 'dart:io';

import 'package:onlineshoppinapp/test_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
   class Helper{
  static const databaseName="Ok.db";
  static const databaseTable="off";
  static const databaseVersion=1;
  static const id="id";
  static const title="title";
  static const description="description";
  static const image="image";
  static const price="price";

  static final Helper instance=Helper();
  static  Database? _database;
  Future<Database?> get database async {
    _database??=  await initDb();
    return _database;
    //   if(_database!=null) return _database;
    //   _database=await initDb();
    //   return _database;
    // }
  }

  initDb() async{
    Directory directory=await getApplicationDocumentsDirectory();
    String path=join(directory.path,databaseName);
    return await openDatabase(path,version: databaseVersion,onCreate: onCreate);

  }
  Future onCreate(Database db,int version)
  async{
    db.execute('''
    CREATE TABLE $databaseTable($id INTEGER PRIMARY KEY AUTOINCREMENT,
    $title text, $description text, $price text, $image text
    )
    ''');
   }

  Future<int> Insert(TestModel test) async {
    Database? db = await instance.database;
    return await db!.insert(databaseTable,test.map());


}

  Future<List<TestModel>> Read() async {
    var procuct = <TestModel>[];

    Database? db = await instance.database;
    var listMap = await db!.query(databaseTable);
    for (var procuctMap in listMap) {
      TestModel p = TestModel.fromMap(procuctMap);
      procuct.add(p);
    }
    return procuct;
  }
  Future<int> delete(var id) async {
    Database? db = await instance.database;
    return await db!.delete(databaseTable, where: "id=?", whereArgs: [id]);
  }

   }