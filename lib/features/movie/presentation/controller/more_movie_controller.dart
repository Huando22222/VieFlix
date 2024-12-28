import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:vie_flix/features/movie/domain/entity/feature_movie_entity.dart';
import 'package:vie_flix/features/movie/domain/usecase/movie/get_list_feature_movie_usecase.dart';

class MoreMovieController extends GetxController {
  final GetListFeatureMovieUsecase getListFeatureMovieUsecase =
      GetIt.instance<GetListFeatureMovieUsecase>();

  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var releatedMovie = <FeatureMovieEntity>[].obs;
  String type = '';
  String link = '';
  var currentPage = 1;
  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    log('type: ${Get.arguments['type']}');
    setEndPoint(type: Get.arguments['type']);
    fetchData(
      page: currentPage,
    );
  }

  Future fetchData({required int page}) async {
    if (page == 1) {
      isLoading.value = true;
    } else {
      isLoadingMore.value = true;
    }

    try {
      final result =
          await getListFeatureMovieUsecase.call(link: '$link$type?page=$page');
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

  void setEndPoint({required String type}) {
    switch (type) {
      case 'phim-le':
        link = 'https://phimapi.com/v1/api/danh-sach/';
        this.type = 'phim-le';
        return;
      case 'phim-bo':
        link = 'https://phimapi.com/v1/api/danh-sach/';
        this.type = 'phim-bo';
        return;
      case 'hoat-hinh':
        link = 'https://phimapi.com/v1/api/danh-sach/';
        this.type = 'hoat-hinh';
        return;
      case 'tv-shows':
        link = 'https://phimapi.com/v1/api/danh-sach/';
        this.type = 'tv-shows';
        return;
      case 'moi-cap-nhat-kkphim':
        link = 'https://phimapi.com/danh-sach/';
        this.type = 'phim-moi-cap-nhat';
        return;
      case 'moi-cap-nhat-NguonC':
        link = 'https://phim.nguonc.com/api/films/';
        this.type = 'phim-moi-cap-nhat';
        return;
      default:
        link = 'https://phim.nguonc.com/api/films/danh-sach/';
        this.type = type;
        return;
    }
  }
}
