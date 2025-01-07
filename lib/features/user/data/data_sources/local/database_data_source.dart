import 'package:vie_flix/core/database/database_helper.dart';
import 'package:vie_flix/features/movie/domain/entity/category_entity.dart';
//https://www.youtube.com/watch?v=bihC6ou8FqQ

class DatabaseDataSource {
  final DatabaseHelper _dbHelper;
  DatabaseDataSource(this._dbHelper);

  static const String createTableQuery = '''
    CREATE TABLE category(
      slug TEXT PRIMARY KEY,
      name TEXT,
      is_selected INTEGER DEFAULT 0
    )
  ''';

  Future<void> updateMultipleCategories(List<String> selectedSlugs) async {
    final db = await _dbHelper.database;
    final batch = db.batch();

    batch.update(
      'category',
      {'is_selected': 0},
      where: null,
    );

    batch.update(
      'category',
      {'is_selected': 1},
      where: 'slug IN (${List.filled(selectedSlugs.length, '?').join(',')})',
      whereArgs: selectedSlugs,
    );

    await batch.commit();
  }

  Future<List<CategoryEntity>> getSelectedCategories() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'category',
      where: 'is_selected = ?',
      whereArgs: [1], //test //1
    );

    return maps
        .map(
          (map) => CategoryEntity(
            slug: map['slug'],
            name: map['name'],
          ),
        )
        .toList();
  }
}
// import 'dart:developer';

// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:vie_flix/core/data/category.dart';
// import 'package:vie_flix/features/movie/domain/entity/category_entity.dart';
// //https://www.youtube.com/watch?v=bihC6ou8FqQ

// class DatabaseDataSource {
//   DatabaseDataSource._init();
//   static final DatabaseDataSource instance = DatabaseDataSource._init();
//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) {
//       log('Database already initialized');
//       return _database!;
//     }
//     log('Initializing database...');
//     _database = await _initDB("movie_database.db");
//     log('Database initialized successfully');
//     return _database!;
//   }

//   Future<Database> _initDB(String filename) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filename);
//     // log("message");
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _createDB,
//       onOpen: (db) {
//         log('Database opened successfully');
//       },
//     );
//   }

//   Future _createDB(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE category(
//         slug TEXT PRIMARY KEY,
//         name TEXT,
//         is_selected INTEGER DEFAULT 0
//       )
//     ''');

//     _insertAllCategories(categories);

//     await db.execute('''
//       CREATE TABLE favorite(
//         slug TEXT PRIMARY KEY ,
//         name TEXT,
//         origin_name TEXT,
//         source TEXT NOT NULL,
//         image_path TEXT NOT NULL
//       )
//     ''');
//   }

//   // Future<void>

//   Future<void> _insertAllCategories(List<CategoryEntity> cate) async {
//     final db = await database;
//     final batch = db.batch();
//     for (var item in cate) {
//       batch.insert(
//         'category',
//         {
//           'slug': item.slug,
//           'name': item.name,
//           'is_selected': 0,
//         },
//       );
//     }
//     await batch.commit();
//   }

//   Future<void> updateMultipleCategories(List<String> selectedSlugs) async {
//     final db = await database;
//     final batch = db.batch();

//     batch.update(
//       'category',
//       {'is_selected': 0},
//       where: null,
//     );

//     batch.update(
//       'category',
//       {'is_selected': 1},
//       where: 'slug IN (${List.filled(selectedSlugs.length, '?').join(',')})',
//       whereArgs: selectedSlugs,
//     );

//     await batch.commit();
//   }

//   Future<List<CategoryEntity>> getSelectedCategories() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query(
//       'category',
//       where: 'is_selected = ?',
//       whereArgs: [1], //test //1
//     );

//     return maps
//         .map(
//           (map) => CategoryEntity(
//             slug: map['slug'],
//             name: map['name'],
//           ),
//         )
//         .toList();
//   }

//   Future<void> close() async {
//     final db = await database; //??
//     return db.close();
//   }
// }
