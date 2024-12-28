import 'package:equatable/equatable.dart';

class FeatureMovieEntity extends Equatable {
  final String source;
  final DateTime modified;
  final String name;
  final String slug;
  final String originName;
  final String posterUrl;
  final String thumbUrl;

  const FeatureMovieEntity({
    required this.source,
    required this.modified,
    required this.name,
    required this.slug,
    required this.originName,
    required this.posterUrl,
    required this.thumbUrl,
  });

  @override
  List<Object?> get props => [
        source,
        modified,
        name,
        slug,
        originName,
        posterUrl,
        thumbUrl,
      ];
}
