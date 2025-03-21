import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:vie_flix/common/widget/Scroll_Colum_padding_widget.dart';
import 'package:vie_flix/common/widget/show_case_custome_widget.dart';
import 'package:vie_flix/config/routes/app_route.dart';
import 'package:vie_flix/features/movie/domain/entity/card_entity.dart';
import 'package:vie_flix/features/movie/presentation/controller/dash_board_controller.dart';
import 'package:vie_flix/features/movie/presentation/screen/test.dart';
import 'package:vie_flix/features/movie/presentation/screen/widget/build_list_view_card_widget.dart';
import 'package:vie_flix/features/movie/presentation/screen/widget/build_title_widget.dart';
import 'package:vie_flix/features/movie/presentation/screen/widget/carouse_widget.dart';
import 'package:vie_flix/features/user/presentation/controller/app_setting_controller.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey keyCard = GlobalKey();

    final DashBoardController dashBoardController =
        Get.find<DashBoardController>();
    final AppSettingController appSettingController =
        Get.find<AppSettingController>();

    final size = MediaQuery.of(context).size;

    return ScrollColumPaddingWidget(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            'VieFlix',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        SizedBox(
          height: size.height * 0.3,
          width: double.infinity,
          child: Obx(
            () {
              if (!dashBoardController.isLoading) {
                if (appSettingController.isShowcaseTriggeredDashboard) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ShowCaseWidget.of(context).startShowCase([
                      keyCard,
                    ]);
                    appSettingController.isShowcaseTriggeredDashboard = false;
                    appSettingController.changeShowcaseTriggered(value: false);
                  });
                }
              }
              return CarouseWidget(
                data: dashBoardController.latestMoviesKKPhim.value
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
            onPressed: () {
              Get.to(Test());
            },
            child: Text("data")),
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
              return ShowCaseCustomeWidget(
                globalKey: keyCard,
                title: "Thể loại",
                description:
                    "Danh sách phim bạn đã thêm vào trước đó.\nThẻ xanh là nguồn KKphim\nThẻ cam là NguonC",
                child: BuildListWiewCardWidget(
                  isLoading:
                      dashBoardController.isLoadingLatestMoviesKKPhim.value,
                  list: dashBoardController.latestMoviesKKPhim.value
                      .map((e) => CardEntity(
                            name: e.name,
                            originName: e.originName,
                            poster: e.posterUrl,
                            thumbnail: e.thumbUrl,
                            slug: e.slug,
                            source: e.source,
                          ))
                      .toList(),
                ),
              );
            },
          ),
        ),
        Obx(
          () {
            if (dashBoardController.isAddingFavorites.value) {
              return const SizedBox.shrink();
            } else {
              return Column(
                children: [
                  ...List.generate(
                    dashBoardController.movieFavListsNC.length,
                    (index) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          BuildTitleWidget(
                            title: dashBoardController.favName[index].name,
                            onTap: () {
                              Get.toNamed(
                                AppRoute.moreMovieScreen,
                                arguments: {
                                  'type':
                                      dashBoardController.favName[index].slug
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.3,
                            child: Obx(
                              () {
                                return BuildListWiewCardWidget(
                                  isLoading: dashBoardController
                                      .isloadingFavStatesNC[index].value,
                                  list: dashBoardController
                                      .movieFavListsNC[index].value
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
                  )
                ],
              );
            }
          },
        ),
        const SizedBox(
          height: 20,
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
                    dashBoardController.isLoadingFeaturedMoviesKKPhim.value,
                list: dashBoardController.featuredMoviesKKPhim.value
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
                    dashBoardController.isLoadingSeriesMoviesKKPhim.value,
                list: dashBoardController.seriesMoviesKKPhim.value
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
                    dashBoardController.isLoadingAnimatedMoviesKKPhim.value,
                list: dashBoardController.animatedMoviesKKPhim.value
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
                isLoading: dashBoardController.isLoadingTvShowsKKPhim.value,
                list: dashBoardController.tvShowsKKPhim.value
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
