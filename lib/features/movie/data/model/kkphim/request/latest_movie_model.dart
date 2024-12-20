import 'package:vie_flix/features/movie/data/model/kkphim/modifield.dart';
import 'package:vie_flix/features/movie/domain/entity/latest_movie_entity.dart';
//https://phimapi.com/danh-sach/phim-moi-cap-nhat?page=1&limit=20

class LatestMovieModel extends LatestMovieEntity {
  LatestMovieModel({
    required super.modified,
    required super.id,
    required super.name,
    required super.slug,
    required super.originName,
    required super.posterUrl,
    required super.thumbUrl,
    required super.year,
  });

  factory LatestMovieModel.fromJson(Map<String, dynamic> json) =>
      LatestMovieModel(
        modified: ModifiedModel.fromJson(json["modified"]),
        id: json["_id"],
        name: json["name"],
        slug: json["slug"],
        originName: json["origin_name"],
        posterUrl: json["poster_url"],
        thumbUrl: json["thumb_url"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "modified": modified.toJson(),
        "_id": id,
        "name": name,
        "slug": slug,
        "origin_name": originName,
        "poster_url": posterUrl,
        "thumb_url": thumbUrl,
        "year": year,
      };
}
