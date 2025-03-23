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
