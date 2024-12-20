class TmdbEntity {
  final String type;
  final String id;
  final int season;
  final double voteAverage;
  final int voteCount;

  TmdbEntity({
    required this.type,
    required this.id,
    required this.season,
    required this.voteAverage,
    required this.voteCount,
  });
}
