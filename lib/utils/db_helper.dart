import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/key_value.dart';

class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'key_value.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE key_value(id INTEGER PRIMARY KEY AUTOINCREMENT, key TEXT, value TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertKeyValue(KeyValue keyValue) async {
    final db = await database;
    await db.insert(
      'key_value',
      keyValue.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteKeyValue(int id) async {
    final db = await database;
    await db.delete(
      'key_value',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<KeyValue>> getKeyValues() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('key_value');
    return List.generate(maps.length, (i) {
      return KeyValue.fromMap(maps[i]);
    });
  }
}