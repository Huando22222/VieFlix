// service_locator.dart
import 'package:get_it/get_it.dart';
import 'package:vie_flix/core/database/database_helper.dart';
import 'package:vie_flix/features/movie/data/data_sources/remote/movie_remote_data_source.dart';
import 'package:vie_flix/features/movie/data/repository/movie_repository_impl.dart';
import 'package:vie_flix/features/movie/domain/repository/movie/movie_repository.dart';
import 'package:vie_flix/features/movie/domain/usecase/movie/get_list_feature_movie_usecase.dart';
import 'package:vie_flix/features/movie/domain/usecase/movie/get_list_search_movie_usecase.dart';
import 'package:vie_flix/features/movie/domain/usecase/movie/get_movie_detail_usecase.dart';
import 'package:vie_flix/features/user/data/data_sources/local/category_database_data_source.dart';
import 'package:vie_flix/features/user/data/data_sources/local/favorite_database_data_source.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Remote Data Source
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(),
  );
  //local data source
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);
  sl.registerLazySingleton<CategoryDatabaseDataSource>(
    () => CategoryDatabaseDataSource(sl<DatabaseHelper>()),
  );
  sl.registerLazySingleton<FavoriteDatabaseDataSource>(
    () => FavoriteDatabaseDataSource(sl<DatabaseHelper>()),
  );
  // Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(),
  );
  // usecase
  sl.registerLazySingleton<GetListFeatureMovieUsecase>(
    () => GetListFeatureMovieUsecase(),
  );
  sl.registerLazySingleton<GetListSearchMovieUsecase>(
    () => GetListSearchMovieUsecase(),
  );
  sl.registerLazySingleton<GetMovieDetailUsecase>(
    () => GetMovieDetailUsecase(),
  );
}
