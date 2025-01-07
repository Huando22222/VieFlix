import 'package:vie_flix/features/movie/domain/entity/favorite_entity.dart';

class FavoriteModel extends FavoriteEntity {
  const FavoriteModel({
    required super.slug,
    required super.name,
    required super.originName,
    required super.source,
    required super.imagePath,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        slug: json["slug"],
        name: json["name"],
        originName: json["origin_name"],
        source: json["source"],
        imagePath: json["image_path"],
      );
}
