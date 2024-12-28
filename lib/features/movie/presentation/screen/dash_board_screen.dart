import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vie_flix/common/widget/Scroll_Colum_padding_widget.dart';
import 'package:vie_flix/config/routes/app_route.dart';
import 'package:vie_flix/features/movie/domain/entity/card_entity.dart';
import 'package:vie_flix/features/movie/presentation/controller/feature_movie_controller.dart';
import 'package:vie_flix/features/movie/presentation/screen/widget/build_list_view_card_widget.dart';
import 'package:vie_flix/features/movie/presentation/screen/widget/build_title_widget.dart';
import 'package:vie_flix/features/movie/presentation/screen/widget/carouse_widget.dart';
import 'package:vie_flix/features/user/presentation/controller/filter_controller.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FeatureMovieController featureMovieController = Get.find();
    //
    final FilterController filterController = Get.find<FilterController>();
    //

    final size = MediaQuery.of(context).size;
    return ScrollColumPaddingWidget(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            'VieFlix',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        SizedBox(
          height: size.height * 0.3,
          width: double.infinity,
          child: Obx(
            () {
              return CarouseWidget(
                data: featureMovieController.latestMoviesKKPhim.value
                    .map((e) => CardEntity(
                          name: e.name,
                          originName: e.originName,
                          poster: e.posterUrl,
                          thumbnail: e.thumbUrl,
                          slug: e.slug,
                          source: e.source,
                        ))
                    .toList(),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            filterController.updateCategory();
          },
          child: Text('update '),
        ),
        ElevatedButton(
          onPressed: () async {
            filterController.test();
          },
          child: Text('log '),
        ),
        ...List.generate(
          featureMovieController.movieFavListsNC.length,
          (index) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                BuildTitleWidget(
                  title: featureMovieController.favName[index].name,
                  onTap: () {
                    Get.toNamed(
                      AppRoute.moreMovieScreen,
                      arguments: {
                        'type': featureMovieController.favName[index].slug
                      },
                    );
                  },
                ),
                SizedBox(
                  height: size.height * 0.3,
                  child: Obx(
                    () {
                      return BuildListWiewCardWidget(
                        isLoading: featureMovieController
                            .isloadingFavStatesNC[index].value,
                        list:
                            featureMovieController.movieFavListsNC[index].value
                                .map((e) => CardEntity(
                                      name: e.name,
                                      originName: e.originName,
                                      poster: e.thumbUrl,
                                      thumbnail: e.thumbUrl,
                                      slug: e.slug,
                                      source: e.source,
                                    ))
                                .toList(),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        BuildTitleWidget(
          title: 'Phim mới cập nhật',
          onTap: () {
            Get.toNamed(
              AppRoute.moreMovieScreen,
              arguments: {'type': 'moi-cap-nhat-kkphim'},
            );
          },
        ),
        SizedBox(
          height: size.height * 0.3,
          child: Obx(
            () {
              return BuildListWiewCardWidget(
                isLoading:
                    featureMovieController.isLoadingLatestMoviesKKPhim.value,
                list: featureMovieController.latestMoviesKKPhim.value
                    .map((e) => CardEntity(
                          name: e.name,
                          originName: e.originName,
                          poster: e.posterUrl,
                          thumbnail: e.thumbUrl,
                          slug: e.slug,
                          source: e.source,
                        ))
                    .toList(),
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        BuildTitleWidget(
          title: 'Phim mới lẻ',
          onTap: () {
            Get.toNamed(
              AppRoute.moreMovieScreen,
              arguments: {'type': 'phim-le'},
            );
          },
        ),
        SizedBox(
          height: size.height * 0.3,
          child: Obx(
            () {
              return BuildListWiewCardWidget(
                isLoading:
                    featureMovieController.isLoadingFeaturedMoviesKKPhim.value,
                list: featureMovieController.featuredMoviesKKPhim.value
                    .map((e) => CardEntity(
                          name: e.name,
                          originName: e.originName,
                          poster: e.posterUrl,
                          thumbnail: e.thumbUrl,
                          slug: e.slug,
                          source: e.source,
                        ))
                    .toList(),
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        BuildTitleWidget(
          title: 'Phim mới bộ',
          onTap: () {
            Get.toNamed(
              AppRoute.moreMovieScreen,
              arguments: {'type': 'phim-bo'},
            );
          },
        ),
        SizedBox(
          height: size.height * 0.3,
          child: Obx(
            () {
              return BuildListWiewCardWidget(
                isLoading:
                    featureMovieController.isLoadingSeriesMoviesKKPhim.value,
                list: featureMovieController.seriesMoviesKKPhim.value
                    .map((e) => CardEntity(
                          name: e.name,
                          originName: e.originName,
                          poster: e.posterUrl,
                          thumbnail: e.thumbUrl,
                          slug: e.slug,
                          source: e.source,
                        ))
                    .toList(),
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        BuildTitleWidget(
          title: 'Phim mới hoạt hình',
          onTap: () {
            Get.toNamed(
              AppRoute.moreMovieScreen,
              arguments: {'type': 'hoat-hinh'},
            );
          },
        ),
        SizedBox(
          height: size.height * 0.3,
          child: Obx(
            () {
              return BuildListWiewCardWidget(
                isLoading:
                    featureMovieController.isLoadingAnimatedMoviesKKPhim.value,
                list: featureMovieController.animatedMoviesKKPhim.value
                    .map((e) => CardEntity(
                          name: e.name,
                          originName: e.originName,
                          poster: e.posterUrl,
                          thumbnail: e.thumbUrl,
                          slug: e.slug,
                          source: e.source,
                        ))
                    .toList(),
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        BuildTitleWidget(
          title: 'Phim mới TV show',
          onTap: () {
            Get.toNamed(
              AppRoute.moreMovieScreen,
              arguments: {'type': 'tv-shows'},
            );
          },
        ),
        SizedBox(
          height: size.height * 0.3,
          child: Obx(
            () {
              return BuildListWiewCardWidget(
                isLoading: featureMovieController.isLoadingTvShowsKKPhim.value,
                list: featureMovieController.tvShowsKKPhim.value
                    .map((e) => CardEntity(
                          name: e.name,
                          originName: e.originName,
                          poster: e.posterUrl,
                          thumbnail: e.thumbUrl,
                          slug: e.slug,
                          source: e.source,
                        ))
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
