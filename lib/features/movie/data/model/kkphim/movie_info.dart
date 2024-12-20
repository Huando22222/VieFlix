import 'package:vie_flix/features/movie/data/model/kkphim/category.dart';
import 'package:vie_flix/features/movie/data/model/kkphim/episodes.dart';
import 'package:vie_flix/features/movie/data/model/kkphim/modifield.dart';
import 'package:vie_flix/features/movie/data/model/kkphim/tmdb_model.dart';
import 'package:vie_flix/features/movie/domain/entity/movie_detail_entity.dart';
import 'package:vie_flix/features/movie/domain/entity/movie_info_entity.dart';

class MovieInfoModel extends MovieInfoEntity {
  MovieInfoModel({
    required super.modified,
    required super.id,
    required super.name,
    required super.slug,
    required super.originName,
    required super.type,
    required super.posterUrl,
    required super.thumbUrl,
    required super.subDocquyen,
    required super.chieurap,
    required super.time,
    required super.episodeCurrent,
    required super.quality,
    required super.lang,
    required super.year,
    required super.category,
    required super.country,
    required super.tmdb,
    required super.content,
    required super.status,
    required super.isCopyright,
    required super.trailerUrl,
    required super.episodeTotal,
    required super.notify,
    required super.showtimes,
    required super.view,
    required super.actor,
    required super.director,
  });

  factory MovieInfoModel.fromJson(Map<String, dynamic> json) {
    return MovieInfoModel(
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
      tmdb: TmdbModel.fromJson(json["tmdb"]),
      content: json["content"] ?? '',
      status: json["status"] ?? '',
      isCopyright: json["is_copyright"] ?? false,
      trailerUrl: json["trailer_url"] ?? '',
      episodeTotal: json["episode_total"] ?? '',
      notify: json["notify"] ?? '',
      showtimes: json["showtimes"] ?? '',
      view: json["view"] ?? 0,
      actor: List<String>.from(json["actor"] ?? []),
      director: List<String>.from(json["director"] ?? []),
    );
  }
}
