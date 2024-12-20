import 'package:vie_flix/features/movie/domain/entity/episodes_entity.dart';
import 'package:vie_flix/features/movie/domain/entity/movie_info_entity.dart';

class MovieDetailEntity {
  final MovieInfoEntity movie;
  final List<EpisodesEntity> episodes;
  MovieDetailEntity({
    required this.movie,
    required this.episodes,
  });
}
