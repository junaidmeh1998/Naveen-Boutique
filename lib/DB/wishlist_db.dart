import 'dart:io' as io;

import 'package:naveenboutique/Models/wishlist_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperWishList {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'wishlist.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE wishlist (id INTEGER PRIMARY KEY, productId VARCHAR UNIQUE, productName TEXT,productPrice INTEGER,image TEXT)');
  }

  Future<WishList> insert(
    WishList wishlistmodel,
  ) async {
    print(wishlistmodel.toMap());
    var dbClient = await db;
    await dbClient?.insert('wishlist', wishlistmodel.toMap());
    return wishlistmodel;
  }

  Future<List<WishList>> getWishList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('wishlist');
    return queryResult.map((e) => WishList.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('wishlist', where: 'id = ?', whereArgs: [id]);
  }
}
