import 'package:dartz/dartz.dart';
import 'package:vie_flix/core/error/failure.dart';
import 'package:vie_flix/features/movie/domain/entity/latest_movie_entity.dart';
import 'package:vie_flix/features/movie/domain/entity/movie_detail_entity.dart';
import 'package:vie_flix/features/movie/domain/entity/search_movie_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<LatestMovieEntity>>> getListLatestMovie({
    required int limit,
    required int page,
  });

  Future<Either<Failure, MovieDetailEntity>> getMovieDetail(
      {required String slug});

  Future<Either<Failure, List<SearchMovieEntity>>> getListSearchMovie({
    required String path,
    required int limit,
    required int page,
  });
}
