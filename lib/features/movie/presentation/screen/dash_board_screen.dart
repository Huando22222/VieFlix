import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vie_flix/common/widget/Scroll_Colum_padding_widget.dart';
import 'package:vie_flix/config/routes/app_route.dart';
import 'package:vie_flix/features/movie/domain/entity/card_entity.dart';
import 'package:vie_flix/features/movie/presentation/controller/animated_movie_controller.dart';
import 'package:vie_flix/features/movie/presentation/controller/feature_movie_controller.dart';
import 'package:vie_flix/features/movie/presentation/controller/latest_movie_controller.dart';
import 'package:vie_flix/features/movie/presentation/controller/series_movie_controller.dart';
import 'package:vie_flix/features/movie/presentation/controller/tv_series_movie_controller.dart';
import 'package:vie_flix/features/movie/presentation/screen/widget/build_list_view_card_widget.dart';
import 'package:vie_flix/features/movie/presentation/screen/widget/build_title_widget.dart';
import 'package:vie_flix/features/movie/presentation/screen/widget/carouse_widget.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LatestMovieController latestMovieController = Get.find();
    final FeatureMovieController featureMovieController =
        Get.find<FeatureMovieController>();
    final SeriesMovieController seriesMovieController =
        Get.find<SeriesMovieController>();
    final AnimatedMovieController animatedMovieController =
        Get.find<AnimatedMovieController>();
    final TvSeriesMovieController tvSeriesMovieController =
        Get.find<TvSeriesMovieController>();
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
                data: latestMovieController.latestMovies.value
                    .map((e) => CardEntity(
                          name: e.name,
                          originName: e.originName,
                          urlImage: e.posterUrl,
                          slug: e.slug,
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
          title: 'Phim mới cập nhật',
          onTap: () {
            Get.toNamed(
              AppRoute.moreMovieScreen,
              arguments: {'type': 1},
            );
          },
        ),
        SizedBox(
          height: size.height * 0.3,
          child: Obx(
            () {
              return BuildListWiewCardWidget(
                isLoading: latestMovieController.isLoading.value,
                list: latestMovieController.latestMovies.value
                    .map((e) => CardEntity(
                          name: e.name,
                          originName: e.originName,
                          urlImage: e.posterUrl,
                          slug: e.slug,
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
              arguments: {'type': 2},
            );
          },
        ),
        SizedBox(
          height: size.height * 0.3,
          child: Obx(
            () {
              return BuildListWiewCardWidget(
                isLoading: featureMovieController.isLoading.value,
                list: featureMovieController.featureMovies.value
                    .map((e) => CardEntity(
                          name: e.name,
                          originName: e.originName,
                          urlImage: e.posterUrl,
                          slug: e.slug,
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
              arguments: {'type': 3},
            );
          },
        ),
        SizedBox(
          height: size.height * 0.3,
          child: Obx(
            () {
              return BuildListWiewCardWidget(
                isLoading: seriesMovieController.isLoading.value,
                list: seriesMovieController.seriesMovies.value
                    .map((e) => CardEntity(
                          name: e.name,
                          originName: e.originName,
                          urlImage: e.posterUrl,
                          slug: e.slug,
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
              arguments: {'type': 3},
            );
          },
        ),
        SizedBox(
          height: size.height * 0.3,
          child: Obx(
            () {
              return BuildListWiewCardWidget(
                isLoading: animatedMovieController.isLoading.value,
                list: animatedMovieController.animatedMovies.value
                    .map((e) => CardEntity(
                          name: e.name,
                          originName: e.originName,
                          urlImage: e.posterUrl,
                          slug: e.slug,
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
              arguments: {'type': 4},
            );
          },
        ),
        SizedBox(
          height: size.height * 0.3,
          child: Obx(
            () {
              return BuildListWiewCardWidget(
                isLoading: tvSeriesMovieController.isLoading.value,
                list: tvSeriesMovieController.tvShows.value
                    .map((e) => CardEntity(
                          name: e.name,
                          originName: e.originName,
                          urlImage: e.posterUrl,
                          slug: e.slug,
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
