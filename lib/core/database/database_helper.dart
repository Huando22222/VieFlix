import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vie_flix/core/data/category.dart';
import 'package:vie_flix/features/user/data/data_sources/local/favorite_database_data_source.dart';
import 'package:vie_flix/features/user/data/data_sources/local/category_database_data_source.dart';

class DatabaseHelper {
  DatabaseHelper._init();
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("movie_database.db");
    return _database!;
  }

  Future<Database> _initDB(String filename) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filename);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    try {
      log("==========================database-header");
      await db.execute(CategoryDatabaseDataSource.createTableQuery);

      final batch = db.batch();
      for (var item in categories) {
        batch.insert(
          'category',
          {
            'slug': item.slug,
            'name': item.name,
            'is_selected': 0,
          },
        );
      }
      await batch.commit();

      await db.execute(FavoriteDatabaseDataSource.createTableQuery);
    } catch (e, stackTrace) {
      log('Error creating database: $e = $stackTrace');
    }
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
