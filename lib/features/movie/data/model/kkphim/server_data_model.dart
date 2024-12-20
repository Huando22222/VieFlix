import 'package:vie_flix/features/movie/domain/entity/server_data_entity.dart';

class ServerDataModel extends ServerDataEntity {
  ServerDataModel({
    required super.name,
    required super.slug,
    required super.filename,
    required super.linkEmbed,
    required super.linkM3U8,
  });
  factory ServerDataModel.fromJson(Map<String, dynamic> json) =>
      ServerDataModel(
        name: json["name"],
        slug: json["slug"],
        filename: json["filename"],
        linkEmbed: json["link_embed"],
        linkM3U8: json["link_m3u8"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "filename": filename,
        "link_embed": linkEmbed,
        "link_m3u8": linkM3U8,
      };
}
