import 'package:equatable/equatable.dart';

class ServerDataEntity extends Equatable {
  final String name;
  final String slug;
  final String linkEmbed;
  final String linkM3U8;

  const ServerDataEntity({
    required this.name,
    required this.slug,
    required this.linkEmbed,
    required this.linkM3U8,
  });

  @override
  List<Object?> get props => [name, slug, linkEmbed, linkM3U8];
}
