import 'package:vie_flix/features/movie/data/model/kkphim/episodes.dart';
import 'package:vie_flix/features/movie/domain/entity/search_movie_entity.dart';
import 'package:vie_flix/features/movie/domain/entity/tmdb_entity.dart';

class MovieInfoEntity extends SearchMovieEntity {
  final TmdbEntity tmdb;
  final String content;
  final String status;
  final bool isCopyright;
  final String trailerUrl;
  final String episodeTotal;
  final String notify;
  final String showtimes;
  final int view;
  final List<String> actor;
  final List<String> director;

  MovieInfoEntity({
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
    required this.tmdb,
    required this.content,
    required this.status,
    required this.isCopyright,
    required this.trailerUrl,
    required this.episodeTotal,
    required this.notify,
    required this.showtimes,
    required this.view,
    required this.actor,
    required this.director,
  });
}
