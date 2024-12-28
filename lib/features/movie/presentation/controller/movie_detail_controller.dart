import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:video_player/video_player.dart';
import 'package:vie_flix/features/movie/domain/entity/movie_detail_entity.dart';
import 'package:vie_flix/features/movie/domain/usecase/movie/get_movie_detail_usecase.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MovieDetailController extends GetxController {
  final GetMovieDetailUsecase getMovieDetailUsecase =
      GetIt.instance<GetMovieDetailUsecase>();

  late WebViewController webViewController;
  RxBool isWebView = false.obs;
  var source = Get.arguments['source'];
  var isLoading = false.obs;
  var isShowingDetail = false.obs;
  var isShowingThumbnail = true.obs;
  var movieDetail = Rx<MovieDetailEntity?>(null);
  var selectEpisode = ''.obs;
  @override
  void onInit() {
    super.onInit();
    log('mv detail: $source');
    fetchData(slug: Get.arguments['slug']);
  }

  Future setSource({required String source}) async {
    this.source = source;
    fetchData(slug: Get.arguments['slug']);
  }

  Future fetchData({
    required String slug,
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
        },
      );
    } catch (e, stackTrace) {
      log("$e == $stackTrace");
    } finally {
      isLoading.value = false;
    }
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
        autoPlay: false,
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
