import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vie_flix/features/user/presentation/screen/skeleton_movie_detail.dart';
import 'package:vie_flix/common/widget/scaffold_widget.dart';
import 'package:vie_flix/features/movie/presentation/controller/movie_detail_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MovieDetailScreen extends StatelessWidget {
  MovieDetailScreen({super.key});
  final MovieDetailController movieDetailController =
      Get.find<MovieDetailController>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ScaffoldWidget(
      showDrawer: false,
      body: Obx(
        () {
          if (movieDetailController.isLoading
                  .value /*||
              movieDetailController.movieDetail.value == null */
              ) {
            return const SkeletonMovieDetail();
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Center(
                    child: Obx(
                      () {
                        if (movieDetailController.isShowingThumbnail.value) {
                          return GestureDetector(
                            onTap: () {
                              if (movieDetailController.isWebView.value) {
                                movieDetailController.changeEpisode(
                                    movieDetailController.movieDetail.value!
                                        .episodes[0].serverData[0].linkEmbed);
                                return;
                              }
                              movieDetailController.changeEpisode(
                                  movieDetailController.movieDetail.value!
                                      .episodes[0].serverData[0].linkM3U8);
                            },
                            child: Stack(
                              children: [
                                Image.network(movieDetailController
                                    .movieDetail.value!.thumbUrl),
                                Center(
                                  child: Icon(
                                    Icons.play_circle_sharp,
                                    color: Colors.black.withOpacity(0.7),
                                    size: size.width * 0.2,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Obx(
                            () {
                              if (movieDetailController.isWebView.value) {
                                return WebViewWidget(
                                    controller: movieDetailController
                                        .webViewController);
                              } else {
                                final chewieController = movieDetailController
                                    .chewieController.value;
                                return chewieController != null &&
                                        chewieController.videoPlayerController
                                            .value.isInitialized
                                    ? Chewie(controller: chewieController)
                                    : SpinKitThreeBounce(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      );
                              }
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        movieDetailController.isWebView.value = false;
                        movieDetailController.changeEpisode(
                            movieDetailController.movieDetail.value!.episodes[0]
                                .serverData[0].linkM3U8);
                      },
                      child: Text('sv1 (recommended)'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        movieDetailController.isWebView.value = true;
                        movieDetailController.changeEpisode(
                            movieDetailController.movieDetail.value!.episodes[0]
                                .serverData[0].linkEmbed);
                      },
                      child: Text('webView'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          movieDetailController.setSource(source: "KK");
                        },
                        child: Text('KKPhim'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          movieDetailController.setSource(source: "NC");
                        },
                        child: Text('NguonC'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          movieDetailController.setSource(source: "OP");
                        },
                        child: Text('OPhim'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movieDetailController.movieDetail.value!.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            movieDetailController.movieDetail.value!.originName,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        movieDetailController.isShowingDetail.value =
                            !movieDetailController.isShowingDetail.value;
                      },
                      icon: Icon(
                        movieDetailController.isShowingDetail.value
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                if (movieDetailController.isShowingDetail.value)
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Text(movieDetailController
                              .movieDetail.value!.description),
                          Table(
                            columnWidths: const {
                              0: IntrinsicColumnWidth(),
                              1: FlexColumnWidth(),
                            },
                            children: [
                              TableRow(
                                children: [
                                  const Text('Thời lượng:'),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: size.width * 0.1),
                                    child: Text(movieDetailController
                                        .movieDetail.value!.time),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text('Quốc gia:'),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: size.width * 0.1),
                                    child: Text(
                                      movieDetailController.movieDetail.value
                                                  ?.country.isNotEmpty ==
                                              true
                                          ? movieDetailController
                                              .movieDetail.value!.country
                                              .map((c) => c)
                                              .join(', ')
                                          : 'No countries available',
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text('Thể loại:'),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: size.width * 0.1),
                                    child: Text(
                                      movieDetailController.movieDetail.value
                                                  ?.category.isNotEmpty ==
                                              true
                                          ? movieDetailController
                                              .movieDetail.value!.category
                                              .map((c) => c)
                                              .join(', ')
                                          : 'No category available',
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text('Phát hành:'),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: size.width * 0.1),
                                    child: Text(movieDetailController
                                        .movieDetail.value!.year
                                        .toString()),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text('Tập mới nhất:'),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: size.width * 0.1),
                                    child: Text(movieDetailController
                                        .movieDetail.value!.episodeCurrent),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text('Tổng số tập:'),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: size.width * 0.1),
                                    child: Text(movieDetailController
                                        .movieDetail.value!.episodeTotal),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text('Diễn viên:'),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: size.width * 0.1),
                                    child: Text(
                                      movieDetailController.movieDetail.value
                                                  ?.actor.isNotEmpty ==
                                              true
                                          ? movieDetailController
                                              .movieDetail.value!.actor
                                          : 'No actor available',
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                if (!movieDetailController.isShowingDetail.value)
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star_rate_rounded,
                                  ),
                                  Text(
                                    "haha",
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              ' lượt đánh giá',
                            ),
                            Spacer(),
                            Image.asset(
                              'assets/images/playlist_icon.png',
                              height: 25,
                              width: 25,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ],
                        ),
                        Text(
                          '${movieDetailController.movieDetail.value!.year} | ${movieDetailController.movieDetail.value!.episodeCurrent} | ${movieDetailController.movieDetail.value!.country.first} ',
                        ),
                        Expanded(
                          child: DefaultTabController(
                            length: movieDetailController
                                    .movieDetail.value!.episodes.length +
                                1,
                            child: Column(
                              children: [
                                TabBar(
                                  dividerColor: Colors.transparent,
                                  tabs: [
                                    ...List.generate(
                                      movieDetailController
                                          .movieDetail.value!.episodes.length,
                                      (index) {
                                        return Tab(
                                            text: movieDetailController
                                                .movieDetail
                                                .value!
                                                .episodes[index]
                                                .serverName);
                                      },
                                    ),
                                    Tab(text: 'liên quan'),
                                  ],
                                ),
                                Expanded(
                                  child: TabBarView(
                                    children: [
                                      ...List.generate(
                                        movieDetailController
                                            .movieDetail.value!.episodes.length,
                                        (index) {
                                          return SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    text: 'Click ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18),
                                                    children: [
                                                      TextSpan(
                                                        text: 'here',
                                                        style: TextStyle(
                                                          color: Colors.blue,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                        ),
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap = () {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                      content: Text(
                                                                          'You clicked on "here"!')),
                                                                );
                                                              },
                                                      ),
                                                      const WidgetSpan(
                                                        alignment:
                                                            PlaceholderAlignment
                                                                .middle,
                                                        child: Icon(
                                                          Icons
                                                              .arrow_drop_down_rounded,
                                                          color: Colors.blue,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                ...List.generate(
                                                  movieDetailController
                                                      .movieDetail
                                                      .value!
                                                      .episodes[index]
                                                      .serverData
                                                      .length,
                                                  (indexEpisode) {
                                                    return _buildEpisodes(
                                                      isSelected: (movieDetailController
                                                                  .selectEpisode
                                                                  .value ==
                                                              movieDetailController
                                                                  .movieDetail
                                                                  .value!
                                                                  .episodes[
                                                                      index]
                                                                  .serverData[
                                                                      indexEpisode]
                                                                  .linkM3U8 ||
                                                          movieDetailController
                                                                  .selectEpisode
                                                                  .value ==
                                                              movieDetailController
                                                                  .movieDetail
                                                                  .value!
                                                                  .episodes[
                                                                      index]
                                                                  .serverData[
                                                                      indexEpisode]
                                                                  .linkEmbed),
                                                      context: context,
                                                      name:
                                                          movieDetailController
                                                              .movieDetail
                                                              .value!
                                                              .episodes[index]
                                                              .serverData[
                                                                  indexEpisode]
                                                              .name,
                                                      thumbnail:
                                                          movieDetailController
                                                              .movieDetail
                                                              .value!
                                                              .thumbUrl,
                                                      onTap: () {
                                                        if (movieDetailController
                                                            .isWebView.value) {
                                                          movieDetailController.changeEpisode(
                                                              movieDetailController
                                                                  .movieDetail
                                                                  .value!
                                                                  .episodes[
                                                                      index]
                                                                  .serverData[
                                                                      indexEpisode]
                                                                  .linkEmbed);
                                                          return;
                                                        }
                                                        movieDetailController
                                                            .changeEpisode(
                                                                movieDetailController
                                                                    .movieDetail
                                                                    .value!
                                                                    .episodes[
                                                                        index]
                                                                    .serverData[
                                                                        indexEpisode]
                                                                    .linkM3U8);
                                                      },
                                                    );
                                                  },
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            // _buildEpisodes(context: context),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildEpisodes({
    required BuildContext context,
    required String thumbnail,
    required String name,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color:
                isSelected ? Colors.black.withOpacity(0.2) : Colors.transparent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: size.height * 0.12,
                  minHeight: size.height * 0.08,
                  maxWidth: size.width * 0.5,
                  minWidth: size.width * 0.4,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                      image: NetworkImage(
                        thumbnail,
                      ),
                      onError: (exception, stackTrace) {
                        // return Ske
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                name,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
