import 'package:vie_flix/features/movie/data/model/kkphim/episodes.dart';
import 'package:vie_flix/features/movie/data/model/kkphim/movie_info.dart';

import 'package:vie_flix/features/movie/domain/entity/movie_detail_entity.dart';

class MovieDetailModel extends MovieDetailEntity {
  MovieDetailModel({
    required super.episodes,
    required super.movie,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      episodes: List<EpisodesModel>.from(
          (json['episodes'] ?? []).map((e) => EpisodesModel.fromJson(e))),
      movie: MovieInfoModel.fromJson(json['movie']),
    );
  }
}
