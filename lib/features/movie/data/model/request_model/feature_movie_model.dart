import 'package:vie_flix/features/movie/domain/entity/feature_movie_entity.dart';

class FeatureMovieModel extends FeatureMovieEntity {
  const FeatureMovieModel({
    required super.source,
    required super.modified,
    required super.name,
    required super.slug,
    required super.originName,
    required super.posterUrl,
    required super.thumbUrl,
  });

  factory FeatureMovieModel.fromJson(Map<String, dynamic> json) =>
      FeatureMovieModel(
        source: (json["modified"] is String) ? "NC" : "KK",
        modified: json["modified"] is String
            ? DateTime.parse(json["modified"])
            : DateTime.parse(json["modified"]["time"]),
        name: json["name"],
        slug: json["slug"],
        originName: json["origin_name"] ?? json["original_name"],
        posterUrl: json["poster_url"],
        thumbUrl: json["thumb_url"],
      );
}
