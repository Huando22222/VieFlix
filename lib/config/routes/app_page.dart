import 'package:get/get.dart';
import 'package:vie_flix/common/binding/bottom_navigation_binding.dart';
import 'package:vie_flix/common/screen/home_screen.dart';
import 'package:vie_flix/features/movie/presentation/binding/animated_movie_binding.dart';
import 'package:vie_flix/features/movie/presentation/binding/feature_movie_binding.dart';
import 'package:vie_flix/features/movie/presentation/binding/latest_movie_binding.dart';
import 'package:vie_flix/features/movie/presentation/binding/more_movie_binding.dart';
import 'package:vie_flix/features/movie/presentation/binding/movie_detail_binding.dart';
import 'package:vie_flix/features/movie/presentation/binding/series_movie_binding.dart';
import 'package:vie_flix/features/movie/presentation/binding/tv_series_movie_binding.dart';
import 'package:vie_flix/features/movie/presentation/screen/dash_board_screen.dart';
import 'package:vie_flix/common/screen/on_boarding_page.dart';
import 'package:vie_flix/config/routes/app_route.dart';
import 'package:vie_flix/features/movie/presentation/screen/more_movie_screen.dart';
import 'package:vie_flix/features/movie/presentation/screen/movie_detail_screen.dart';

class AppPage {
  static final routes = [
    GetPage(
      name: AppRoute.onBoardingScreen,
      page: () => const OnBoardingPage(),
    ),
    GetPage(
      name: AppRoute.dashboardScreen,
      page: () => const DashBoardScreen(),
      bindings: [
        LatestMovieBinding(),
      ],
    ),
    GetPage(
      name: AppRoute.detailMovieScreen,
      page: () => MovieDetailScreen(),
      bindings: [
        MovieDetailBinding(),
      ],
    ),
    GetPage(
      name: AppRoute.mainScreen,
      page: () => const HomeScreen(),
      bindings: [
        BottomNavigationBinding(),
        LatestMovieBinding(),
        FeatureMovieBinding(),
        SeriesMovieBinding(),
        AnimatedMovieBinding(),
        TvSeriesMovieBinding(),
      ],
    ),
    GetPage(
      name: AppRoute.moreMovieScreen,
      page: () => const MoreMovieScreen(),
      bindings: [
        MoreMovieBinding(),
      ],
    ),
  ];
}
