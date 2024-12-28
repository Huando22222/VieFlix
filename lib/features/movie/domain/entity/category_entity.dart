import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String slug;
  final String name;

  const CategoryEntity({
    required this.slug,
    required this.name,
  });

  @override
  List<Object> get props => [slug, name];
}
