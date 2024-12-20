import 'package:vie_flix/features/movie/data/model/kkphim/modifield.dart';
//https://phimapi.com/danh-sach/phim-moi-cap-nhat?page=1&limit=20

class LatestMovieEntity {
  final ModifiedModel modified;
  final String id;
  final String name;
  final String slug;
  final String originName;
  final String posterUrl;
  final String thumbUrl;
  final int year;

  LatestMovieEntity({
    required this.modified,
    required this.id,
    required this.name,
    required this.slug,
    required this.originName,
    required this.posterUrl,
    required this.thumbUrl,
    required this.year,
  });
}
