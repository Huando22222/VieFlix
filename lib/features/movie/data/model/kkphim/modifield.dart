import 'package:vie_flix/features/movie/domain/entity/modifield_entity.dart';

class ModifiedModel extends ModifiedEntity {
  ModifiedModel({
    required super.time,
  });

  factory ModifiedModel.fromJson(Map<String, dynamic> json) => ModifiedModel(
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "time": time.toIso8601String(),
      };
}
