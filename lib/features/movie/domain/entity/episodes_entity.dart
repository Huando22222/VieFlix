import 'package:equatable/equatable.dart';
import 'package:vie_flix/features/movie/domain/entity/server_data_entity.dart';

class EpisodesEntity extends Equatable {
  final String serverName;
  final List<ServerDataEntity> serverData;

  const EpisodesEntity({
    required this.serverName,
    required this.serverData,
  });

  @override
  List<Object?> get props => [serverName, serverData];
}
