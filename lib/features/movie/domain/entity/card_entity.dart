// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CardEntity extends Equatable {
  final String name;
  final String originName;
  final String poster;
  final String thumbnail;
  final String slug;
  final String source;
  const CardEntity({
    required this.name,
    required this.originName,
    required this.poster,
    required this.thumbnail,
    required this.slug,
    required this.source,
  });

  @override
  List<Object?> get props =>
      [name, originName, poster, thumbnail, slug, source];
}
