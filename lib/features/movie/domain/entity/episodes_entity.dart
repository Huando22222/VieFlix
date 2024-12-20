import 'package:vie_flix/features/movie/domain/entity/server_data_entity.dart';

class EpisodesEntity {
  final String serverName;
  final List<ServerDataEntity> serverData;

  EpisodesEntity({
    required this.serverName,
    required this.serverData,
  });
}
