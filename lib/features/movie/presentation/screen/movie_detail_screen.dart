import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:vie_flix/common/widget/show_case_custome_widget.dart';
import 'package:vie_flix/core/constant/constants.dart';
import 'package:vie_flix/features/movie/presentation/screen/widget/card_horiziontal_widget.dart';
import 'package:vie_flix/features/user/presentation/controller/app_setting_controller.dart';
import 'package:vie_flix/features/user/presentation/controller/favorite_controller.dart';
import 'package:vie_flix/features/user/presentation/screen/skeleton_movie_detail.dart';
import 'package:vie_flix/common/widget/scaffold_widget.dart';
import 'package:vie_flix/features/movie/presentation/controller/movie_detail_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final MovieDetailController movieDetailController =
      Get.find<MovieDetailController>();
  final AppSettingController appSettingController =
      Get.find<AppSettingController>();
  final FavoriteController favoriteController = Get.find<FavoriteController>();

  final GlobalKey keySource = GlobalKey();
  final GlobalKey keyChannel = GlobalKey();
  final GlobalKey keyShowGrid = GlobalKey();
  final GlobalKey keyAddFavorite = GlobalKey();
  final GlobalKey keyRealeted = GlobalKey();
  final GlobalKey keyMoreInfo = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ScaffoldWidget(
      showDrawer: false,
      body: Obx(
        () {
          if (movieDetailController.isLoading.value) {
            return const SkeletonMovieDetail();
          } else {
            if (appSettingController.isShowcaseTriggeredMovieDetail) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ShowCaseWidget.of(context).startShowCase([
                  keyChannel,
                  keySource,
                  keyShowGrid,
                  keyAddFavorite,
                  keyMoreInfo,
                  keyRealeted,
                ]);
                appSettingController.isShowcaseTriggeredMovieDetail = false;
              });
            }

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
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  child: Image.network(movieDetailController
                                              .movieDetail.value!.source ==
                                          "KK"
                                      ? movieDetailController
                                          .movieDetail.value!.thumbUrl
                                      : movieDetailController
                                          .movieDetail.value!.posterUrl),
                                ),
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
                ShowCaseCustomeWidget(
                  globalKey: keyChannel,
                  title: "Channel",
                  description:
                      "Với KKphim, Ophim hoạt động tốt với m3u8 channel.\nNguonC bạn nên sử webView",
                  child: Row(
                    children: [
                      Obx(
                        () {
                          return _buildServer(
                              text: 'm3u8',
                              onTap: () {
                                movieDetailController.isWebView.value = false;
                                movieDetailController.changeEpisode(
                                    movieDetailController.movieDetail.value!
                                        .episodes[0].serverData[0].linkM3U8);
                              },
                              isSelected:
                                  !movieDetailController.isWebView.value);
                        },
                      ),
                      Obx(
                        () {
                          return _buildServer(
                              text: 'webView',
                              onTap: () {
                                movieDetailController.isWebView.value = true;
                                movieDetailController.changeEpisode(
                                    movieDetailController.movieDetail.value!
                                        .episodes[0].serverData[0].linkEmbed);
                              },
                              isSelected:
                                  movieDetailController.isWebView.value);
                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ShowCaseCustomeWidget(
                  globalKey: keySource,
                  title: "Nguồn phim",
                  description:
                      "bạn có thể lựa chọn nguồn phim nếu nguồn hiện tại không hoạt động",
                  child: Row(
                    children: [
                      _buildSource(source: "KK", text: "KKphim"),
                      _buildSource(source: "NC", text: "NguonC"),
                      _buildSource(source: "OP", text: "Ophim"),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShowCaseCustomeWidget(
                      globalKey: keyShowGrid,
                      title: "Danh sách tập",
                      description: "lựa chọn hiển thị danh sách tập",
                      child: IconButton(
                        onPressed: () {
                          appSettingController.changeShowGridEpisodes();
                        },
                        icon: Icon(
                          appSettingController.isShowGridEpisodes.value
                              ? Icons.grid_view
                              : Icons.menu,
                        ),
                      ),
                    ),
                    ShowCaseCustomeWidget(
                      globalKey: keyAddFavorite,
                      title: "Favorite",
                      description: "Thêm vào xem sau",
                      child: IconButton(
                        onPressed: () {
                          if (favoriteController.isLoading.value) {
                            return;
                          }
                          favoriteController.addOrRemoveFavorite(
                              movieDetailController.favoriteMovie!);
                        },
                        icon: Icon(
                          favoriteController.favorites.contains(
                                  movieDetailController.favoriteMovie!)
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),
                      ),
                    ),
                    const Spacer(),
                    ShowCaseCustomeWidget(
                      globalKey: keyMoreInfo,
                      title: "Chi tiết phim",
                      description:
                          "Bạn có thể xem chi tiết diễn viên, thời lượng, tập, ... ",
                      child: IconButton(
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
                    ),
                  ],
                ),
                if (movieDetailController.isShowingDetail.value)
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
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
                        Expanded(
                          child: DefaultTabController(
                            length: movieDetailController
                                    .movieDetail.value!.episodes.length +
                                1,
                            child: Column(
                              children: [
                                ShowCaseCustomeWidget(
                                  globalKey: keyRealeted,
                                  title: "Server và Liên quan",
                                  description:
                                      "Server VietSub và lồng tiếng và các phần phim liên quan ",
                                  child: TabBar(
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
                                      const Tab(text: 'liên quan'),
                                    ],
                                  ),
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
                                                Obx(
                                                  () {
                                                    if (appSettingController
                                                        .isShowGridEpisodes
                                                        .value) {
                                                      return Wrap(
                                                        children: [
                                                          ...List.generate(
                                                            movieDetailController
                                                                .movieDetail
                                                                .value!
                                                                .episodes[index]
                                                                .serverData
                                                                .length,
                                                            (indexEpisode) {
                                                              return _buildEpisodesGrid(
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
                                                                            .episodes[index]
                                                                            .serverData[indexEpisode]
                                                                            .linkEmbed),
                                                                context:
                                                                    context,
                                                                name: movieDetailController
                                                                    .movieDetail
                                                                    .value!
                                                                    .episodes[
                                                                        index]
                                                                    .serverData[
                                                                        indexEpisode]
                                                                    .name,
                                                                onTap: () {
                                                                  if (movieDetailController
                                                                      .isWebView
                                                                      .value) {
                                                                    movieDetailController.changeEpisode(movieDetailController
                                                                        .movieDetail
                                                                        .value!
                                                                        .episodes[
                                                                            index]
                                                                        .serverData[
                                                                            indexEpisode]
                                                                        .linkEmbed);
                                                                    return;
                                                                  }
                                                                  movieDetailController.changeEpisode(movieDetailController
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
                                                      );
                                                    } else {
                                                      return Column(
                                                        children: [
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
                                                                            .episodes[index]
                                                                            .serverData[indexEpisode]
                                                                            .linkEmbed),
                                                                context:
                                                                    context,
                                                                name: movieDetailController
                                                                    .movieDetail
                                                                    .value!
                                                                    .episodes[
                                                                        index]
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
                                                                      .isWebView
                                                                      .value) {
                                                                    movieDetailController.changeEpisode(movieDetailController
                                                                        .movieDetail
                                                                        .value!
                                                                        .episodes[
                                                                            index]
                                                                        .serverData[
                                                                            indexEpisode]
                                                                        .linkEmbed);
                                                                    return;
                                                                  }
                                                                  movieDetailController.changeEpisode(movieDetailController
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
                                                      );
                                                    }
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
                                            ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return Container();
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                final item =
                                                    movieDetailController
                                                        .relatedList[index];
                                                return CardHorizontalWidget(
                                                  slug: item.slug,
                                                  name: item.name,
                                                  originName: item.originName,
                                                  source: item.source,
                                                  imagePath: item.source == "KK"
                                                      ? "${Constants.baseUrlPoster}${item.posterUrl}"
                                                      : item.posterUrl,
                                                );
                                              },
                                              itemCount: movieDetailController
                                                  .relatedList.length,
                                            ),
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

  Widget _buildServer({
    required String text,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: isSelected ? Colors.amber : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Text(
            text,
            maxLines: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildSource({
    required String source,
    required String text,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {
          movieDetailController.setSource(source: source);
        },
        child: Obx(
          () {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: movieDetailController.source.value == source
                    ? Colors.amber
                    : Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: Text(text),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEpisodesGrid({
    required BuildContext context,
    required String name,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: isSelected
                  ? Colors.black.withOpacity(0.2)
                  : Colors.transparent,
            ),
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodyLarge,
            )),
      ),
    );
  }
}
