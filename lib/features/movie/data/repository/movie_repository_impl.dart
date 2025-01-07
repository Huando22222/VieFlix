import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:vie_flix/core/constant/constants.dart';
import 'package:vie_flix/core/error/failure.dart';
import 'package:vie_flix/features/movie/data/data_sources/remote/movie_remote_data_source.dart';
import 'package:vie_flix/features/movie/domain/entity/feature_movie_entity.dart';
import 'package:vie_flix/features/movie/domain/entity/movie_detail_entity.dart';
import 'package:vie_flix/features/movie/domain/repository/movie/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource movieRemoteDataSource =
      GetIt.instance<MovieRemoteDataSource>();

  @override
  Future<Either<Failure, List<FeatureMovieEntity>>> getListFeatureMovie({
    required String link,
  }) async {
    try {
      final result =
          await movieRemoteDataSource.getListFeatureMovie(link: link);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(errorMessage: Constants.errorServerString));
    }
  }

  @override
  Future<Either<Failure, MovieDetailEntity>> getMovieDetail(
      {required String slug, required String source}) async {
    try {
      final result = await movieRemoteDataSource.getMovieDetail(
          slug: slug, source: source);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(errorMessage: Constants.errorServerString));
    }
  }

  @override
  Future<Either<Failure, List<FeatureMovieEntity>>> getListSearchMovie({
    required String source,
    required String key,
  }) async {
    try {
      final result = await movieRemoteDataSource.getListSearchMovie(
        source: source,
        key: key,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(errorMessage: Constants.errorServerString));
    }
  }
}
