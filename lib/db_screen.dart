import 'dart:io';
import 'package:onlineshoppinapp/product_model_screen.dart';
import 'package:path_provider/path_provider.dart' ;
import 'package:sqflite/sqflite.dart' ;


import 'model_screen.dart';

class DatabaseHelper {

  DatabaseHelper._privateConstructor(); // Name constructor to create instance of database
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  // getter for database

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS
    // to store database

    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/AppNo.db';

    // open/ create database at a given path
    var studentsDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );

    return studentsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        '''CREATE TABLE Login (id integer primary key autoincrement,
         name text, Email text, password text,role integer
        )''');
    await  db.execute(
        '''CREATE TABLE AddP(id integer primary key autoincrement,
         title text, description text, price text, picture text
        )''');
  }

  Future<int> insertion(Registeration obj) async {
    Database db = await instance.database;
    int result = await db.insert("Login", obj.map());
    return result;
  }


  Future<List<Map<String, Object?>>> read() async {
    final Database db = await instance.database;
    return await db.query("Login");
  }

  Future<int> productInsert(ProductModle productObj) async {
    Database db = await instance.database;
    int resultp = await db.insert("AddP", productObj.map2());
    return resultp;
  }

 // Future<List<Map<String, Object?>>> productRead() async {
  //  final Database db = await instance.database;
  //  return await db.query("shopAutt");
 // }
  Future<List<ProductModle>> productRead() async {
    var procuct = <ProductModle>[];

    Database db = await instance.database;
    var listMap = await db.query("AddP");
    for (var procuctMap in listMap) {
      ProductModle p = ProductModle.fromMap(procuctMap);
      procuct.add(p);
    }
    return procuct;
  }
  Future<int> delete(var id) async {
    Database db = await instance.database;
    return await db.delete("AddP", where: "id=?", whereArgs: [id]);
  }

  }

