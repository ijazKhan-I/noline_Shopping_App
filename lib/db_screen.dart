import 'dart:io';
import 'package:onlineshoppinapp/product_model_screen.dart';
import 'package:path_provider/path_provider.dart' ;
import 'package:sqflite/sqflite.dart' ;


import 'cart_model.dart';
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
    String path = '${directory.path}/databaseM.db';
    print(path);

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
         title text, description text, price text, picture text,priceInt integer
        )''');
    await  db.execute(
        '''CREATE TABLE AddToCart(id integer primary key autoincrement,
             userID integer,productID integer,
         FOREIGN key (userID) REFERENCES Login (id),FOREIGN key (productID) REFERENCES Addp (id)
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

  Future<int> insertCard(Add_To_Cart obj) async {
    Database db = await instance.database;
    int result = await db.insert("AddToCart", obj.map());
    return result;
  }
  Future<List<Add_To_Cart>> ReadCart() async {
    var Carts = <Add_To_Cart>[];

    Database db = await instance.database;
    var listMap = await db.rawQuery('''SELECT * FROM AddToCart
    INNER JOIN Login on AddToCart.userID=Login.id
    INNER JOIN AddP on AddToCart.productID=AddP.id
    ''');

    for (var cartMap in listMap) {
      Add_To_Cart  cart= Add_To_Cart.fromMap(cartMap);
      Carts.add(cart);
    }


    return Carts;
  }
  Future<int> deleteCart(var id) async {
    Database db = await instance.database;
    return await db.delete("AddToCart", where: "id=?", whereArgs: [id]);
  }
  }

