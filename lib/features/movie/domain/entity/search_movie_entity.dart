import 'package:vie_flix/features/movie/domain/entity/category_entity.dart';
import 'package:vie_flix/features/movie/domain/entity/latest_movie_entity.dart';
//https://phimapi.com/v1/api/tim-kiem?keyword=Trung%20Qu%E1%BB%91c&limit=64

class SearchMovieEntity extends LatestMovieEntity {
  final String type;
  final bool subDocquyen;
  final bool chieurap;
  final String time;
  final String episodeCurrent;
  final String quality;
  final String lang;
  final List<CategoryEntity> category;
  final List<CategoryEntity> country;

  SearchMovieEntity({
    required super.modified,
    required super.id,
    required super.name,
    required super.slug,
    required super.originName,
    required super.posterUrl,
    required super.thumbUrl,
    required super.year,
    required this.type,
    required this.subDocquyen,
    required this.chieurap,
    required this.time,
    required this.episodeCurrent,
    required this.quality,
    required this.lang,
    required this.category,
    required this.country,
  });
}
