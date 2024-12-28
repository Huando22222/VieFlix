import 'package:vie_flix/features/movie/domain/entity/server_data_entity.dart';

class ServerDataModel extends ServerDataEntity {
  const ServerDataModel({
    required super.name,
    required super.slug,
    required super.linkEmbed,
    required super.linkM3U8,
  });
  factory ServerDataModel.fromJson(Map<String, dynamic> json) =>
      ServerDataModel(
        name: json["name"],
        slug: json["slug"],
        linkEmbed: json['link_embed'] ?? json['embed'],
        linkM3U8: json['link_m3u8'] ?? json['m3u8'],
      );
}
