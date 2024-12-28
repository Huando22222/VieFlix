import 'package:vie_flix/features/movie/domain/entity/episodes_entity.dart';
import 'package:vie_flix/features/movie/domain/entity/feature_movie_entity.dart';

class MovieDetailEntity extends FeatureMovieEntity {
  final String time;
  final String description;
  final String episodeTotal;
  final String episodeCurrent;
  final String actor;
  final String director;
  final String quality;
  final String language;
  final String year;
  final List<String> category;
  final List<String> country;
  final List<EpisodesEntity> episodes;

  const MovieDetailEntity({
    required super.source,
    required this.time,
    required this.description,
    required this.episodeTotal,
    required this.episodeCurrent,
    required this.actor,
    required this.director,
    required this.quality,
    required this.language,
    required this.year,
    required this.category,
    required this.country,
    required this.episodes,
    required super.modified,
    required super.name,
    required super.slug,
    required super.originName,
    required super.posterUrl,
    required super.thumbUrl,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        time,
        description,
        episodeTotal,
        episodeCurrent,
        actor,
        director,
        quality,
        language,
        year,
        category,
        country,
        episodes,
      ];
}
