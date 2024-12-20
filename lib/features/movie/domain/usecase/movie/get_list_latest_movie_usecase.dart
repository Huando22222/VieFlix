import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:vie_flix/core/error/failure.dart';
import 'package:vie_flix/features/movie/domain/entity/latest_movie_entity.dart';
import 'package:vie_flix/features/movie/domain/repository/movie/movie_repository.dart';

class GetListLatestMovieUsecase {
  final MovieRepository _movieRepository = GetIt.instance<MovieRepository>();

  Future<Either<Failure, List<LatestMovieEntity>>> call(
      {required int limit, required int page}) async {
    return await _movieRepository.getListLatestMovie(limit: limit, page: page);
  }
}
