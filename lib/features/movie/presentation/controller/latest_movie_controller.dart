import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:vie_flix/features/movie/domain/entity/latest_movie_entity.dart';
import 'package:vie_flix/features/movie/domain/usecase/movie/get_list_latest_movie_usecase.dart';

class LatestMovieController extends GetxController {
  final GetListLatestMovieUsecase getListLatestMovieUsecase =
      GetIt.instance<GetListLatestMovieUsecase>();

  var latestMovies = <LatestMovieEntity>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData(page: 1, limit: 10);
  }

  Future fetchData({required int page, required int limit}) async {
    isLoading.value = true;
    try {
      final result =
          await getListLatestMovieUsecase.call(limit: limit, page: page);
      result.fold(
        (l) {
          Get.snackbar('thất bại', l.errorMessage);
        },
        (r) {
          latestMovies.assignAll(r);
        },
      );
    } catch (e, stacktrace) {
      debugPrint('LatestMovieController: ${e.toString()} - $stacktrace');
    } finally {
      isLoading.value = false;
    }
  }
}
