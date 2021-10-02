import 'dart:io';

import 'package:flutter/services.dart';
import 'package:menu_ordering_app/model/products_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProductsDatabase {
  static final ProductsDatabase instance = ProductsDatabase._init();

  static Database? _database;

  ProductsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('products.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "demo_asset_example.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      print("Creating new database copy from database assets");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "products.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing databse from assets");
    }

    return await openDatabase(path, version: 2);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE $products ( 
      ${ProductFields.id} $idType, 
      ${ProductFields.name} $textType,
      ${ProductFields.category} $textType,
      ${ProductFields.brand} $textType,
      ${ProductFields.price} $integerType,
      )
    ''');
  }

  //ignore oncreate

  Future<Product> readProduct(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      products,
      columns: ProductFields.values,
      where: '${ProductFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Product.fromJson(maps.first);
    } else {
      throw Exception('ID $id notfound');
    }
  }

  Future<List<Product>> readByCategory(String category) async {
    final db = await instance.database;

    final result = await db.query(
      products,
      where: '${ProductFields.category} = ?',
      whereArgs: [category],
    );
    return result.map((json) => Product.fromJson(json)).toList();
  }

  Future<List<Product>> readAll() async {
    final db = await instance.database;

    final result = await db.query(products);
    return result.map((json) => Product.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
