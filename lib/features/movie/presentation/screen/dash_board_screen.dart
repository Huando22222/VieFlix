import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:vie_flix/common/widget/Scroll_Colum_padding_widget.dart';
import 'package:vie_flix/common/widget/show_case_custome_widget.dart';
import 'package:vie_flix/config/routes/app_route.dart';
import 'package:vie_flix/features/movie/domain/entity/card_entity.dart';
import 'package:vie_flix/features/movie/presentation/controller/dash_board_controller.dart';
import 'package:vie_flix/features/movie/presentation/screen/widget/build_list_view_card_widget.dart';
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
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.surface,
            theme.colorScheme.surface.withOpacity(0.8),
            theme.colorScheme.background,
          ],
          stops: const [0.0, 0.3, 1.0],
        ),
      ),
      child: ScrollColumPaddingWidget(
        children: [
          _buildAppHeader(context, theme),

          const SizedBox(height: 20),

          _buildFeaturedSection(context, size, dashBoardController,
              appSettingController, keyCard),

          const SizedBox(height: 32),

          _buildMovieSection(
            context: context,
            title: 'Phim mới cập nhật',
            icon: Icons.fiber_new_rounded,
            size: size,
            dashBoardController: dashBoardController,
            keyCard: keyCard,
            onTap: () => Get.toNamed(
              AppRoute.moreMovieScreen,
              arguments: {
                'type': 'moi-cap-nhat-kkphim',
                'title': 'Phim mới cập nhật'
              },
            ),
            movieList: dashBoardController.latestMoviesKKPhim,
            isLoading: dashBoardController.isLoadingLatestMoviesKKPhim,
          ),

          // Favorite Categories
          _buildFavoriteCategories(context, size, dashBoardController),

          const SizedBox(height: 24),

          // Movie Categories Grid
          _buildMovieCategoriesGrid(context, size, dashBoardController),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildAppHeader(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(0.1),
            theme.colorScheme.primary.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.movie_rounded,
              color: theme.colorScheme.onPrimary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'VieFlix',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  'Khám phá thế giới điện ảnh',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedSection(
    BuildContext context,
    Size size,
    DashBoardController dashBoardController,
    AppSettingController appSettingController,
    GlobalKey keyCard,
  ) {
    return Container(
      height: size.height * 0.45,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Obx(() {
          if (!dashBoardController.isLoading) {
            if (appSettingController.isShowcaseTriggeredDashboard) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ShowCaseWidget.of(context).startShowCase([keyCard]);
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
        }),
      ),
    );
  }

  Widget _buildMovieSection({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Size size,
    required DashBoardController dashBoardController,
    required GlobalKey keyCard,
    required VoidCallback onTap,
    required RxList movieList,
    required RxBool isLoading,
  }) {
    final theme = Theme.of(context);

    return Column(
      children: [
        _buildSectionHeader(context, title, icon, onTap),
        const SizedBox(height: 16),
        Container(
          height: size.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: theme.colorScheme.surface.withOpacity(0.5),
          ),
          child: Obx(() {
            return ShowCaseCustomeWidget(
              globalKey: keyCard,
              title: "Thể loại",
              description:
                  "Danh sách phim bạn đã thêm vào trước đó.\nThẻ xanh là nguồn KKphim\nThẻ cam là NguonC",
              child: BuildListViewCardWidget(
                isLoading: isLoading.value,
                list: movieList.value
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
          }),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: theme.colorScheme.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          Material(
            color: Colors.transparent, // Đảm bảo nền trong suốt nếu cần
            child: InkWell(
              onTap: onTap,
              borderRadius:
                  BorderRadius.circular(4), // Tuỳ chọn: làm đẹp hiệu ứng
              splashColor: theme.colorScheme.primary
                  .withOpacity(0.2), // Tuỳ chọn: chỉnh màu hiệu ứng
              highlightColor: Colors.transparent, // Loại bỏ màu đè
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 4.0), // Tăng vùng nhấn
                child: Text(
                  'Xem thêm',
                  style: TextStyle(color: theme.colorScheme.primary),
                ),
              ),
            ),
          )

          // TextButton.icon(
          //   onPressed: onTap,
          //   icon: Icon(
          //     Icons.arrow_forward_ios_rounded,
          //     size: 16,
          //     color: theme.colorScheme.primary,
          //   ),
          //   label: Text(
          //     'Xem thêm',
          //     style: TextStyle(color: theme.colorScheme.primary),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildFavoriteCategories(BuildContext context, Size size,
      DashBoardController dashBoardController) {
    return Obx(() {
      if (dashBoardController.isAddingFavorites.value) {
        return const SizedBox.shrink();
      } else {
        return Column(
          children: List.generate(
            dashBoardController.movieFavListsNC.length,
            (index) => Container(
              margin: const EdgeInsets.only(bottom: 24),
              child: _buildMovieSection(
                context: context,
                title: dashBoardController.favName[index].name,
                icon: Icons.favorite_rounded,
                size: size,
                dashBoardController: dashBoardController,
                keyCard: GlobalKey(),
                onTap: () => Get.toNamed(
                  AppRoute.moreMovieScreen,
                  arguments: {
                    'type': dashBoardController.favName[index].slug,
                    'title': dashBoardController.favName[index].name
                  },
                ),
                movieList: dashBoardController.movieFavListsNC[index],
                isLoading: dashBoardController.isloadingFavStatesNC[index],
              ),
            ),
          ),
        );
      }
    });
  }

  Widget _buildMovieCategoriesGrid(BuildContext context, Size size,
      DashBoardController dashBoardController) {
    final categories = [
      {
        'title': 'Phim mới lẻ',
        'icon': Icons.local_movies_rounded,
        'type': 'phim-le',
        'displayTitle': 'Phim Lẻ',
        'list': dashBoardController.featuredMoviesKKPhim,
        'loading': dashBoardController.isLoadingFeaturedMoviesKKPhim
      },
      {
        'title': 'Phim mới bộ',
        'icon': Icons.tv_rounded,
        'type': 'phim-bo',
        'displayTitle': 'Phim Bộ',
        'list': dashBoardController.seriesMoviesKKPhim,
        'loading': dashBoardController.isLoadingSeriesMoviesKKPhim
      },
      {
        'title': 'Phim mới hoạt hình',
        'icon': Icons.animation_rounded,
        'type': 'hoat-hinh',
        'displayTitle': 'Hoạt Hình',
        'list': dashBoardController.animatedMoviesKKPhim,
        'loading': dashBoardController.isLoadingAnimatedMoviesKKPhim
      },
      {
        'title': 'Phim mới TV show',
        'icon': Icons.live_tv_rounded,
        'type': 'tv-shows',
        'displayTitle': 'TV shows',
        'list': dashBoardController.tvShowsKKPhim,
        'loading': dashBoardController.isLoadingTvShowsKKPhim
      },
    ];

    return Column(
      children: categories
          .map((category) => Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: _buildMovieSection(
                  context: context,
                  title: category['title'] as String,
                  icon: category['icon'] as IconData,
                  size: size,
                  dashBoardController: dashBoardController,
                  keyCard: GlobalKey(),
                  onTap: () => Get.toNamed(
                    AppRoute.moreMovieScreen,
                    arguments: {
                      'type': category['type'] as String,
                      'title': category['displayTitle'] as String,
                    },
                  ),
                  movieList: category['list'] as RxList,
                  isLoading: category['loading'] as RxBool,
                ),
              ))
          .toList(),
    );
  }
}
