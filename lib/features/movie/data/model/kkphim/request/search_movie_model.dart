import 'package:vie_flix/features/movie/data/model/kkphim/category.dart';
import 'package:vie_flix/features/movie/data/model/kkphim/modifield.dart';
import 'package:vie_flix/features/movie/data/model/kkphim/request/latest_movie_model.dart';
import 'package:vie_flix/features/movie/domain/entity/search_movie_entity.dart';
//https://phimapi.com/v1/api/tim-kiem?keyword=Trung%20Qu%E1%BB%91c&limit=64

class SearchMovieModel extends SearchMovieEntity {
  SearchMovieModel({
    required super.modified,
    required super.id,
    required super.name,
    required super.slug,
    required super.originName,
    required super.posterUrl,
    required super.thumbUrl,
    required super.year,
    required super.type,
    required super.subDocquyen,
    required super.chieurap,
    required super.time,
    required super.episodeCurrent,
    required super.quality,
    required super.lang,
    required super.category,
    required super.country,
  });

  factory SearchMovieModel.fromJson(Map<String, dynamic> json) {
    return SearchMovieModel(
      modified: ModifiedModel.fromJson(json["modified"]),
      id: json["id"] ?? '',
      name: json["name"] ?? '',
      slug: json["slug"] ?? '',
      originName: json["origin_name"] ?? '',
      posterUrl: json["poster_url"] ?? '',
      thumbUrl: json["thumb_url"] ?? '',
      year: json["year"] ?? '',
      type: json["type"] ?? '',
      subDocquyen: json["sub_docquyen"] ?? false,
      chieurap: json["chieurap"] ?? false,
      time: json["time"] ?? '',
      episodeCurrent: json["episode_current"] ?? '',
      quality: json["quality"] ?? '',
      lang: json["lang"] ?? '',
      category: List<CategoryModel>.from(
          (json["category"] ?? []).map((x) => CategoryModel.fromJson(x))),
      country: List<CategoryModel>.from(
          (json["country"] ?? []).map((x) => CategoryModel.fromJson(x))),
    );
  }
}
