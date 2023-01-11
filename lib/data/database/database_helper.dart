import 'package:restapp/data/model/list_restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _favorite = 'favorite';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/favoriterestaurant.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_favorite (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            pictureId TEXT,
            city TEXT,
            rating double
          )     
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();

    return _database;
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_favorite, restaurant.toJson());
  }

  Future<List<Restaurant>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_favorite);

    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db!.delete(
      _favorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Map> getFavoritebyId(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _favorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }
}
