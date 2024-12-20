import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:vie_flix/features/movie/domain/entity/search_movie_entity.dart';
import 'package:vie_flix/features/movie/domain/usecase/movie/get_list_search_movie_usecase.dart';

class MoreMovieController extends GetxController {
  final GetListSearchMovieUsecase getListSearchMovieUsecase =
      GetIt.instance<GetListSearchMovieUsecase>();

  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var releatedMovie = <SearchMovieEntity>[].obs;
  var searchType = '';
  var currentPage = 1;
  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    searchType = getType(typeInInt: Get.arguments['type']);
    fetchData(page: currentPage);
  }

  Future fetchData({required int page}) async {
    if (page == 1) {
      isLoading.value = true;
    } else {
      isLoadingMore.value = true;
    }

    try {
      final result = await getListSearchMovieUsecase.call(
        path: searchType,
        limit: limit,
        page: page,
      );
      result.fold(
        (l) {
          Get.snackbar('Thất bại', l.errorMessage);
        },
        (r) {
          if (page == 1) {
            releatedMovie.assignAll(r);
          } else {
            releatedMovie.addAll(r);
          }
          currentPage = page;
        },
      );
    } catch (e, stacktrace) {
      log('MoreMovieController: ${e.toString()} - $stacktrace');
    } finally {
      if (page == 1) {
        isLoading.value = false;
      } else {
        isLoadingMore.value = false;
      }
    }
  }

  Future loadMore() async {
    log("loadMore $currentPage");
    if (!isLoadingMore.value) {
      fetchData(page: currentPage + 1);
    }
  }

  String getType({required int typeInInt}) {
    switch (typeInInt) {
      case 1:
        return 'phim-le';
      case 2:
        return 'phim-bo';
      case 3:
        return 'hoat-hinh';
      case 4:
        return 'tv-shows';
      default:
        return 'phim-le';
    }
  }
}
