import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:vie_flix/core/constant/constants.dart';
import 'package:vie_flix/core/error/failure.dart';
import 'package:vie_flix/features/movie/data/data_sources/remote/movie_remote_data_source.dart';
import 'package:vie_flix/features/movie/data/model/kkphim/request/latest_movie_model.dart';
import 'package:vie_flix/features/movie/domain/entity/latest_movie_entity.dart';
import 'package:vie_flix/features/movie/domain/entity/movie_detail_entity.dart';
import 'package:vie_flix/features/movie/domain/entity/search_movie_entity.dart';

import 'package:vie_flix/features/movie/domain/repository/movie/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource movieRemoteDataSource =
      GetIt.instance<MovieRemoteDataSource>();

  @override
  Future<Either<Failure, List<LatestMovieEntity>>> getListLatestMovie({
    required int limit,
    required int page,
  }) async {
    try {
      final result = await movieRemoteDataSource.getListLatestMovie(
          limit: limit, page: page);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(errorMessage: Constants.errorServerString));
    }
  }

  @override
  Future<Either<Failure, MovieDetailEntity>> getMovieDetail(
      {required String slug}) async {
    try {
      final result = await movieRemoteDataSource.getMovieDetail(slug: slug);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(errorMessage: Constants.errorServerString));
    }
  }

  @override
  Future<Either<Failure, List<SearchMovieEntity>>> getListSearchMovie({
    required String path,
    required int limit,
    required int page,
  }) async {
    try {
      final result = await movieRemoteDataSource.getListSearchMovie(
          path: path, limit: limit, page: page);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(errorMessage: Constants.errorServerString));
    }
  }
}
