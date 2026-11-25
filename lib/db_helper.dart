import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'destination.dart';

// Task 4: SQLite helper that caches destinations locally
class DBHelper {
  static Database? _db;

  // Opens (or creates) destinations.db the first time it is called
  static Future<Database> get db async {
    _db ??= await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final String path = join(await getDatabasesPath(), 'destinations.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE destinations('
              'name TEXT PRIMARY KEY, '
              'capital TEXT, '
              'region TEXT, '
              'population INTEGER, '
              'flagUrl TEXT)',
        );
      },
    );
  }

  // Inserts every destination; replaces rows that already exist (same name).
  // Uses a batch so ~250 inserts are sent in one go.
  static Future<void> cacheDestinations(List<Destination> destinations) async {
    final database = await db;
    final batch = database.batch();
    for (final d in destinations) {
      batch.insert(
        'destinations',
        d.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  // Reads every cached row back into a Destination
  static Future<List<Destination>> getCachedDestinations() async {
    final database = await db;
    final List<Map<String, dynamic>> rows = await database.query('destinations');
    return rows.map((row) => Destination.fromMap(row)).toList();
  }
}