import 'package:vie_flix/features/movie/data/model/common/server_data_model.dart';
import 'package:vie_flix/features/movie/domain/entity/episodes_entity.dart';
import 'package:vie_flix/features/movie/domain/entity/server_data_entity.dart';

class EpisodesModel extends EpisodesEntity {
  const EpisodesModel({
    required super.serverName,
    required super.serverData,
  });

  factory EpisodesModel.fromJson(Map<String, dynamic> json) => EpisodesModel(
        serverName: json["server_name"] ?? '',
        serverData: List<ServerDataEntity>.from(
            (json["server_data"] ?? json['items'] ?? [])
                .map((x) => ServerDataModel.fromJson(x))),
      );
}
