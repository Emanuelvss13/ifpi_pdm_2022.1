import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  get database async {
    if (_database != null) {
      return _database;
    }

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
        join(
          await getDatabasesPath(),
          'cripto.db',
        ),
        version: 1,
        onCreate: _onCreate);
  }

  _onCreate(db, version) async {
    await db.execute(_favorites);
  }

  String get _favorites => '''
    CREATE TABLE favorites(
      id TEXT PRIMARY KEY,
      name TEXT,
      symbol TEXT,
      image_url TEXT
    )
  ''';
}
