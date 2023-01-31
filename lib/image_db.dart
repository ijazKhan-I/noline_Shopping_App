
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart' as path;

import 'image_model.dart';

class DatabaseHelper2 {
  static const imageTable = "imagetable";
  static const dbVersion = 1;

  static const idProfileColumn = "id";
  static const titleProfileColumn = "title";
  static const descriptiondProfileColumn = "description";
  static const priceProfileColumn = "price";
  static const image64bitColumn = "image64bit";

  static Future _onCreate(Database db, int version) {
    return db.execute("""
    CREATE TABLE $imageTable(
    $idProfileColumn INTEGER PRIMARY KEY AUTOINCREMENT,
    $titleProfileColumn TEXT,
    $descriptiondProfileColumn TEXT,
    $priceProfileColumn TEXT,
    $image64bitColumn TEXT
    

    )
    """);
  }

  static open() async {
    final rootPath = await getDatabasesPath();

    print("DB OPENED");
    final dbPath = path.join(rootPath, "Image.db");

    return openDatabase(dbPath, onCreate: _onCreate, version: dbVersion);
  }

  static Future insertProfile(Map<String, dynamic> row) async {
    final db = await DatabaseHelper2.open();
    print("ROW INSERTED");
    return await db.insert(imageTable, row);
  }

  static getAllProfile() async {
    final db = await DatabaseHelper2.open();

    List<Map<String, dynamic>> mapList = await db.query(imageTable);

    return List.generate(
        mapList.length, (index) => ProfileModel.fromMap(mapList[index]));
  }
  Future<int> delete(int id) async {
    Database db = await DatabaseHelper2.open();
    int result = await db.delete(imageTable, where: "id=?", whereArgs: [id]);
    return result;
  }

}