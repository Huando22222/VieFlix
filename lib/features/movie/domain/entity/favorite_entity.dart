import 'package:equatable/equatable.dart';

class FavoriteEntity /* extends Equatable*/ {
  final String slug;
  final String name;
  final String originName;
  final String source;
  final String imagePath;

  const FavoriteEntity({
    required this.slug,
    required this.name,
    required this.originName,
    required this.source,
    required this.imagePath,
  });

  // @override //???? equatable not working
  // List<Object> get props => [
  //       slug,
  //       name,
  //       originName,
  //       source,
  //       imagePath,
  //     ];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoriteEntity &&
        other.slug == slug &&
        other.name == name &&
        other.originName == originName &&
        other.source == source &&
        other.imagePath == imagePath;
  }

  @override
  int get hashCode =>
      slug.hashCode ^
      name.hashCode ^
      originName.hashCode ^
      source.hashCode ^
      imagePath.hashCode;
}
