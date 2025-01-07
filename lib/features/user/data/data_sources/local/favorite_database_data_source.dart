import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:vie_flix/core/database/database_helper.dart';
import 'package:vie_flix/features/movie/data/model/common/favorite_model.dart';
import 'package:vie_flix/features/movie/domain/entity/favorite_entity.dart';
//https://www.youtube.com/watch?v=bihC6ou8FqQ

class FavoriteDatabaseDataSource {
  final DatabaseHelper _dbHelper;

  FavoriteDatabaseDataSource(this._dbHelper);

  static const String createTableQuery = '''
    CREATE TABLE favorite(
      slug TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      origin_name TEXT NOT NULL,
      source TEXT NOT NULL,
      image_path TEXT NOT NULL
    )
  ''';

  Future<void> addFavorite({required FavoriteEntity favorite}) async {
    final db = await _dbHelper.database;
    await db.insert(
      'favorite',
      {
        'slug': favorite.slug,
        'name': favorite.name,
        'origin_name': favorite.originName,
        'source': favorite.source,
        'image_path': favorite.imagePath,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    log("add/Conflict ${favorite.slug}");
  }

  Future<void> deleteFavorite({required String slug}) async {
    final db = await _dbHelper.database;
    log("delete $slug");
    await db.delete(
      'favorite',
      where: 'slug = ?',
      whereArgs: [slug],
    );
  }

  Future<List<FavoriteEntity>> getFavorites() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> favorites = await db.query('favorite');
    log(" db getFavorites: ${favorites.length}");
    return favorites.map((e) => FavoriteModel.fromJson(e)).toList();
  }
}
