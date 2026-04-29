import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/kamus_model.dart';

class DbHelper {
  static Database? _database;
  static const String _tableName = 'favorites';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'kamus_gaul.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY,
            kata TEXT NOT NULL,
            arti TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> addFavorite(KamusModel kamus) async {
    final db = await database;
    return await db.insert(
      _tableName,
      kamus.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> removeFavorite(int id) async {
    final db = await database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<KamusModel>> getFavorites() async {
    final db = await database;
    final maps = await db.query(_tableName, orderBy: 'kata ASC');
    return maps.map((e) => KamusModel.fromMap(e)).toList();
  }

  Future<bool> isFavorite(int id) async {
    final db = await database;
    final result = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }

  Future<List<KamusModel>> searchFavorites(String query) async {
    final db = await database;
    final maps = await db.query(
      _tableName,
      where: 'kata LIKE ? OR arti LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'kata ASC',
    );
    return maps.map((e) => KamusModel.fromMap(e)).toList();
  }
}
