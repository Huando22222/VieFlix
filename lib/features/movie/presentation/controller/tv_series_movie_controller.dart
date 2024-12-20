import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:vie_flix/features/movie/domain/entity/search_movie_entity.dart';
import 'package:vie_flix/features/movie/domain/usecase/movie/get_list_search_movie_usecase.dart';

class TvSeriesMovieController extends GetxController {
  final GetListSearchMovieUsecase getListSearchMovieUsecase =
      GetIt.instance<GetListSearchMovieUsecase>();

  var isLoading = false.obs;
  var tvShows = <SearchMovieEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData(path: 'tv-shows', page: 1, limit: 10);
  }

  Future fetchData(
      {required String path, required int page, required int limit}) async {
    isLoading.value = true;
    try {
      final result = await getListSearchMovieUsecase.call(
        path: path,
        limit: limit,
        page: page,
      );
      result.fold(
        (l) {
          Get.snackbar('thất bại', l.errorMessage);
        },
        (r) {
          tvShows.assignAll(r);
        },
      );
    } catch (e, stacktrace) {
      log('LatestMovieController: ${e.toString()} - $stacktrace');
    } finally {
      isLoading.value = false;
    }
  }
}
