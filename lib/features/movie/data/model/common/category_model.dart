import 'package:vie_flix/features/movie/domain/entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.slug,
    required super.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      slug: json['slug'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'name': name,
    };
  }
}
