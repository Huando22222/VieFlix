import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:video_player/video_player.dart';
import 'package:vie_flix/features/movie/domain/entity/movie_detail_entity.dart';
import 'package:vie_flix/features/movie/domain/usecase/movie/get_movie_detail_usecase.dart';

class MovieDetailController extends GetxController {
  final GetMovieDetailUsecase getMovieDetailUsecase =
      GetIt.instance<GetMovieDetailUsecase>();

  var isLoading = false.obs;
  var isShowingDetail = false.obs;
  var isShowingThumbnail = true.obs;
  var movieDetail = Rx<MovieDetailEntity?>(null);
  var selectEpisode = ''.obs;
  @override
  void onInit() {
    super.onInit();
    fetchData(slug: Get.arguments['slug']);
    // initializePlayer('https://s4.phim1280.tv/20241123/tUuN4bwo/index.m3u8');
  }

  Future fetchData({required String slug}) async {
    try {
      isLoading.value = true;
      final result = await getMovieDetailUsecase.call(slug: slug);
      result.fold(
        (l) {
          Get.snackbar('thất bại', l.errorMessage);
        },
        (r) {
          movieDetail.value = r;
          // selectEpisode.value =
          //     movieDetail.value!.episodes[0].serverData[0].linkM3U8;
        },
      );
    } catch (e, stackTrace) {
      log("$e == $stackTrace");
    } finally {
      // isLoading.value = true;
      isLoading.value = false;
    }
  }

  void changeEpisode(String newEpisodeUrl) {
    isShowingThumbnail.value = false;
    selectEpisode.value = newEpisodeUrl;

    initializePlayer(newEpisodeUrl);
  }

  ////video widget
  VideoPlayerController? _videoPlayerController;
  Rx<ChewieController?> chewieController = Rx<ChewieController?>(null);

  void initializePlayer(String videoUrl) async {
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
  }

  @override
  void onClose() {
    if (_videoPlayerController != null) {
      _videoPlayerController!.dispose();
    }
    if (chewieController.value != null) {
      chewieController.value!.dispose();
    }
    super.onClose();
  }
}
