import 'package:vie_flix/features/movie/domain/entity/tmdb_entity.dart';

class TmdbModel extends TmdbEntity {
  TmdbModel({
    required super.type,
    required super.id,
    required super.season,
    required super.voteAverage,
    required super.voteCount,
  });
  factory TmdbModel.fromJson(Map<String, dynamic> json) => TmdbModel(
        type: json["type"] ?? "",
        id: json["id"] ?? "",
        season: json["season"] ?? 0,
        voteAverage: json["vote_average"] != null
            ? double.tryParse(json["vote_average"].toString())!
            : 0.0,
        voteCount: json["vote_count"] ?? 0,
      );
}
