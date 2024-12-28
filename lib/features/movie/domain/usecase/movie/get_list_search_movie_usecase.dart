import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:vie_flix/core/error/failure.dart';
import 'package:vie_flix/features/movie/domain/entity/feature_movie_entity.dart';
import 'package:vie_flix/features/movie/domain/repository/movie/movie_repository.dart';

class GetListSearchMovieUsecase {
  final MovieRepository _movieRepository = GetIt.instance<MovieRepository>();

  Future<Either<Failure, List<FeatureMovieEntity>>> call(
      {required String path, required int limit, required int page}) async {
    return await _movieRepository.getListSearchMovie(
      path: path,
      limit: limit,
      page: page,
    );
  }
}
