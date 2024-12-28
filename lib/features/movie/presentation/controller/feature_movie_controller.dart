import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:vie_flix/features/movie/domain/entity/category_entity.dart';
import 'package:vie_flix/features/movie/domain/entity/feature_movie_entity.dart';
import 'package:vie_flix/features/movie/domain/usecase/movie/get_list_feature_movie_usecase.dart';
import 'package:vie_flix/features/user/presentation/controller/filter_controller.dart';

class FeatureMovieController extends GetxController {
  final GetListFeatureMovieUsecase getListFeatureMovieUsecase =
      GetIt.instance<GetListFeatureMovieUsecase>();
  final FilterController filterController = Get.find<FilterController>();

  RxList<FeatureMovieEntity> latestMoviesKKPhim = <FeatureMovieEntity>[].obs;
  RxBool isLoadingLatestMoviesKKPhim = false.obs;

  RxList<FeatureMovieEntity> featuredMoviesKKPhim = <FeatureMovieEntity>[].obs;
  RxBool isLoadingFeaturedMoviesKKPhim = false.obs;

  RxList<FeatureMovieEntity> seriesMoviesKKPhim = <FeatureMovieEntity>[].obs;
  RxBool isLoadingSeriesMoviesKKPhim = false.obs;

  RxList<FeatureMovieEntity> animatedMoviesKKPhim = <FeatureMovieEntity>[].obs;
  RxBool isLoadingAnimatedMoviesKKPhim = false.obs;

  RxList<FeatureMovieEntity> tvShowsKKPhim = <FeatureMovieEntity>[].obs;
  RxBool isLoadingTvShowsKKPhim = false.obs;

  List<RxList<FeatureMovieEntity>> movieFavListsNC = [];
  List<RxBool> isloadingFavStatesNC = [];
  List<CategoryEntity> favName = [];

  @override
  void onInit() {
    super.onInit();
    fetchData(
      link: 'https://phimapi.com/danh-sach/phim-moi-cap-nhat?page=1',
      list: latestMoviesKKPhim,
      isloading: isLoadingLatestMoviesKKPhim,
    );
    fetchData(
      link: 'https://phimapi.com/v1/api/danh-sach/phim-le',
      list: featuredMoviesKKPhim,
      isloading: isLoadingFeaturedMoviesKKPhim,
    );
    fetchData(
      link: 'https://phimapi.com/v1/api/danh-sach/phim-bo',
      list: seriesMoviesKKPhim,
      isloading: isLoadingSeriesMoviesKKPhim,
    );
    fetchData(
      link: 'https://phimapi.com/v1/api/danh-sach/hoat-hinh',
      list: animatedMoviesKKPhim,
      isloading: isLoadingAnimatedMoviesKKPhim,
    );
    fetchData(
      link: 'https://phimapi.com/v1/api/danh-sach/tv-shows',
      list: tvShowsKKPhim,
      isloading: isLoadingTvShowsKKPhim,
    );
    loadFavoriteList();
  }

  void loadFavoriteList() async {
    favName.clear();
    movieFavListsNC.clear();
    isloadingFavStatesNC.clear();

    for (int i = 0; i < filterController.fav.length; i++) {
      favName.add(filterController.fav.value[i]);
      movieFavListsNC.add(RxList<FeatureMovieEntity>([]));
      isloadingFavStatesNC.add(false.obs);
    }

    for (int i = 0; i < filterController.fav.length; i++) {
      await fetchData(
        link:
            'https://phim.nguonc.com/api/films/danh-sach/${filterController.fav[i].slug}?page=1',
        list: movieFavListsNC[i],
        isloading: isloadingFavStatesNC[i],
      );
    }
  }

  Future fetchData({
    required String link,
    required RxList<FeatureMovieEntity> list,
    required RxBool isloading,
  }) async {
    isloading.value = true;
    try {
      final result = await getListFeatureMovieUsecase.call(link: link);
      result.fold(
        (l) {
          Get.snackbar('thất bại', l.errorMessage);
        },
        (r) {
          list.assignAll(r);
        },
      );
    } catch (e, stacktrace) {
      log('$link: ${e.toString()} - $stacktrace');
    } finally {
      isloading.value = false;
    }
  }
}
