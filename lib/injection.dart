// service_locator.dart
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:vie_flix/features/movie/data/data_sources/remote/movie_remote_data_source.dart';
import 'package:vie_flix/features/movie/data/repository/movie_repository_impl.dart';
import 'package:vie_flix/features/movie/domain/repository/movie/movie_repository.dart';
import 'package:vie_flix/features/movie/domain/usecase/movie/get_list_latest_movie_usecase.dart';
import 'package:vie_flix/features/movie/domain/usecase/movie/get_list_search_movie_usecase.dart';
import 'package:vie_flix/features/movie/domain/usecase/movie/get_movie_detail_usecase.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Remote Data Source
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(),
  );
  // Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(),
  );
  // usecase
  sl.registerLazySingleton<GetListLatestMovieUsecase>(
    () => GetListLatestMovieUsecase(),
  );
  sl.registerLazySingleton<GetListSearchMovieUsecase>(
    () => GetListSearchMovieUsecase(),
  );
  sl.registerLazySingleton<GetMovieDetailUsecase>(
    () => GetMovieDetailUsecase(),
  );
}
