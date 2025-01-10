import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:video_player/video_player.dart';
import 'package:vie_flix/features/movie/domain/entity/favorite_entity.dart';
import 'package:vie_flix/features/movie/domain/entity/feature_movie_entity.dart';
import 'package:vie_flix/features/movie/domain/entity/movie_detail_entity.dart';
import 'package:vie_flix/features/movie/domain/usecase/movie/get_list_search_movie_usecase.dart';
import 'package:vie_flix/features/movie/domain/usecase/movie/get_movie_detail_usecase.dart';
import 'package:vie_flix/features/user/presentation/controller/app_setting_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MovieDetailController extends GetxController {
  final GetMovieDetailUsecase getMovieDetailUsecase =
      GetIt.instance<GetMovieDetailUsecase>();
  final GetListSearchMovieUsecase getListSearchMovieUsecase =
      GetIt.instance<GetListSearchMovieUsecase>();

  final AppSettingController appSettingController =
      Get.find<AppSettingController>();

  late WebViewController webViewController;
  RxBool isWebView = false.obs;
  RxString source = '${Get.arguments['source']}'.obs;
  RxBool isLoading = false.obs;
  RxBool isShowingDetail = false.obs;
  RxBool isShowingThumbnail = true.obs;
  // var movieDetail = Rx<MovieDetailEntity?>(null);
  Rx<MovieDetailEntity?> movieDetail = Rx<MovieDetailEntity?>(null);
  RxList<FeatureMovieEntity> relatedList = <FeatureMovieEntity>[].obs;
  RxString selectEpisode = ''.obs;
  FavoriteEntity? favoriteMovie;
  @override
  void onInit() {
    super.onInit();
    log('mv detail: ${source.value}');
    fetchData(slug: Get.parameters['slug']!, source: source.value);
  }

  Future setSource({required String source}) async {
    fetchData(slug: Get.parameters['slug']!, source: source);
  }

  Future fetchData({
    required String slug,
    required String source,
  }) async {
    try {
      isLoading.value = true;
      final result = await getMovieDetailUsecase.call(
        slug: slug,
        source: source,
      );
      result.fold(
        (l) {
          Get.snackbar('thất bại', l.errorMessage);
        },
        (r) {
          movieDetail.value = r;
          favoriteMovie = FavoriteEntity(
            slug: r.slug,
            name: r.name,
            originName: r.originName,
            source: r.source,
            imagePath: r.posterUrl,
          );
          this.source.value = source;
          //
          _getListSearch(key: movieDetail.value!.originName);
        },
      );
    } catch (e, stackTrace) {
      log("$e == $stackTrace");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _getListSearch({required String key}) async {
    try {
      int lengthToKeep = (key.length * 2 / 3).floor();
      key = key.substring(0, lengthToKeep);
      final futureKK = getListSearchMovieUsecase.call(source: 'KK', key: key);
      final futureNC = getListSearchMovieUsecase.call(source: 'NC', key: key);

      final results = await Future.wait([futureKK, futureNC]);
      final kkResults = results[0];
      final ncResults = results[1];

      List<FeatureMovieEntity> kkMovies = [];
      List<FeatureMovieEntity> ncMovies = [];

      kkResults.fold(
        (l) {
          log('Error in KK results: $l');
        },
        (r) {
          kkMovies = r;
        },
      );

      ncResults.fold(
        (l) {
          log('Error in NC results: $l');
        },
        (r) {
          ncMovies = r;
        },
      );

      final List<FeatureMovieEntity> interleavedList = [];
      final int maxLength =
          kkMovies.length > ncMovies.length ? kkMovies.length : ncMovies.length;

      for (int i = 0; i < maxLength; i++) {
        if (i < kkMovies.length) {
          interleavedList.add(kkMovies[i]);
        }
        if (i < ncMovies.length) {
          interleavedList.add(ncMovies[i]);
        }
      }

      relatedList.value = interleavedList;
    } catch (e) {
      log('Error getting relatedList results: $e');
      relatedList.clear();
    } finally {}
  }

  void changeEpisode(String newEpisodeUrl) {
    isShowingThumbnail.value = false;
    selectEpisode.value = newEpisodeUrl;

    if (isWebView.value) {
      // closem3u8();
      webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ))
        ..loadRequest(
          Uri.parse(
            selectEpisode.value,
          ),
        );
      return;
    }
    initializePlayer(newEpisodeUrl);
  }

  ////video widget
  VideoPlayerController? _videoPlayerController;
  Rx<ChewieController?> chewieController = Rx<ChewieController?>(null);

  void initializePlayer(String videoUrl) async {
    try {
      if (_videoPlayerController != null) {
        await _videoPlayerController!.dispose();
      }
      if (chewieController.value != null) {
        chewieController.value!.dispose();
      }
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(videoUrl),
      );

      await _videoPlayerController!.initialize();

      chewieController.value = ChewieController(
        videoPlayerController: _videoPlayerController!,
        aspectRatio: _videoPlayerController!.value.aspectRatio,
        autoPlay: appSettingController.isAutoPlayVideo.value,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.red,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.white,
        ),
      );
    } catch (e, stackTrace) {
      log('$e == $stackTrace');
    }
  }

  void closem3u8() {
    if (_videoPlayerController != null) {
      _videoPlayerController!.dispose();
    }
    if (chewieController.value != null) {
      chewieController.value!.dispose();
    }
  }

  @override
  void onClose() {
    closem3u8();
    super.onClose();
  }
}
