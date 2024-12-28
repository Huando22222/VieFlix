import 'package:dartz/dartz.dart';
import 'package:vie_flix/core/error/failure.dart';
import 'package:vie_flix/features/movie/domain/entity/feature_movie_entity.dart';
import 'package:vie_flix/features/movie/domain/entity/movie_detail_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<FeatureMovieEntity>>> getListFeatureMovie({
    required String link,
  });

  Future<Either<Failure, MovieDetailEntity>> getMovieDetail({
    required String slug,
    required String source,
  });

  Future<Either<Failure, List<FeatureMovieEntity>>> getListSearchMovie({
    required String path,
    required int limit,
    required int page,
  });
}
