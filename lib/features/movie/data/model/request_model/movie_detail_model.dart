import 'package:vie_flix/features/movie/data/model/common/episodes.dart';
import 'package:vie_flix/features/movie/domain/entity/episodes_entity.dart';
import 'package:vie_flix/features/movie/domain/entity/movie_detail_entity.dart';

class MovieDetailModel extends MovieDetailEntity {
  const MovieDetailModel({
    required super.time,
    required super.description,
    required super.episodeTotal,
    required super.episodeCurrent,
    required super.actor,
    required super.director,
    required super.quality,
    required super.language,
    required super.category,
    required super.country,
    required super.year,
    required super.episodes,
    required super.source,
    required super.modified,
    required super.name,
    required super.slug,
    required super.originName,
    required super.posterUrl,
    required super.thumbUrl,
  });

  factory MovieDetailModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return MovieDetailModel(
      source: json["episodes"] != null ? "KK" : "NC",
      modified: json["movie"]["modified"] is String
          ? DateTime.parse(json["movie"]["modified"])
          : DateTime.parse(json["movie"]["modified"]["time"]),
      name: json["movie"]["name"],
      slug: json["movie"]["slug"],
      originName:
          json["movie"]["origin_name"] ?? json["movie"]["original_name"],
      posterUrl: json["movie"]["poster_url"],
      thumbUrl: json["movie"]["thumb_url"],
      time: json["movie"]["time"] ?? "",
      description: json["movie"]["description"] ?? json["movie"]["content"],
      actor: json["movie"]["casts"] ??
          (json["movie"]["actor"] != null
              ? (json["movie"]["actor"] as List).join(', ')
              : ""),
      director: json["movie"]["director"] != null
          ? (json["movie"]["director"] is String)
              ? json["movie"]["director"]
              : (json["movie"]["director"] as List).join(', ')
          : "",
      category: json["movie"]['category'] != null
          ? (json["movie"]['category'] is List)
              ? List<String>.from(
                  json["movie"]['category'].map((item) => item['name']))
              : (json["movie"]['category']['2'] != null)
                  ? List<String>.from(json["movie"]['category']['2']['list']
                      .map((item) => item['name']))
                  : []
          : [],
      country:
          (json["movie"]['country'] != null && json["movie"]['country'] is List)
              ? List<String>.from(
                  json["movie"]['country'].map((item) => item['name']))
              : (json["movie"]['category']['4'] != null)
                  ? List<String>.from(json["movie"]['category']['4']['list']
                      .map((item) => item['name']))
                  : [],
      year: (json["movie"]['year'] != null)
          ? json["movie"]['year'].toString()
          : (json["movie"]['category']['3'] != null)
              ? (json["movie"]['category']['3']['list'] as List)[0]["name"]
              : "",
      episodeCurrent:
          json["movie"]["current_episode"] ?? json["movie"]["episode_current"],
      episodeTotal: json["movie"]["episode_total"] ??
          json["movie"]["total_episodes"]?.toString() ??
          '0',
      language: json["movie"]["language"] ?? json["movie"]["lang"],
      quality: json["movie"]["quality"],
      episodes: (json["episodes"] != null && json["episodes"] is List)
          ? List<EpisodesEntity>.from(
              json["episodes"].map((x) => EpisodesModel.fromJson(x)))
          : (json["movie"]["episodes"] != null &&
                  json["movie"]["episodes"] is List)
              ? List<EpisodesEntity>.from(json["movie"]["episodes"]
                  .map((x) => EpisodesModel.fromJson(x)))
              : [],
    );
  }
}
