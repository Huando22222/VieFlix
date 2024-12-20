import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:vie_flix/core/error/failure.dart';
import 'package:vie_flix/features/movie/domain/entity/movie_detail_entity.dart';
import 'package:vie_flix/features/movie/domain/repository/movie/movie_repository.dart';

class GetMovieDetailUsecase {
  final MovieRepository _movieRepository = GetIt.instance<MovieRepository>();

  Future<Either<Failure, MovieDetailEntity>> call(
      {required String slug}) async {
    return await _movieRepository.getMovieDetail(slug: slug);
  }
}
