import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:vie_flix/features/movie/presentation/binding/search_movie_binding.dart';
import 'package:vie_flix/features/movie/presentation/controller/movie_detail_controller.dart';
import 'package:vie_flix/features/user/presentation/binding/bottom_navigation_binding.dart';
import 'package:vie_flix/features/user/presentation/binding/favorite_binding.dart';
import 'package:vie_flix/features/user/presentation/screen/home_screen.dart';
import 'package:vie_flix/features/movie/presentation/binding/dash_board_binding.dart';
import 'package:vie_flix/features/movie/presentation/binding/more_movie_binding.dart';
import 'package:vie_flix/config/routes/app_route.dart';
import 'package:vie_flix/features/movie/presentation/screen/more_movie_screen.dart';
import 'package:vie_flix/features/movie/presentation/screen/movie_detail_screen.dart';
import 'package:vie_flix/features/user/presentation/screen/on_boarding_page.dart';
import 'package:vie_flix/features/user/presentation/screen/policy_screen.dart';

class AppPage {
  static final routes = [
    GetPage(
      name: AppRoute.onBoardingScreen,
      page: () => OnBoardingPage(),
    ),
    GetPage(
      name: '${AppRoute.detailMovieScreen}/:slug',
      page: () => ShowCaseWidget(
        builder: (context) => const MovieDetailScreen(),
      ),
      // bindings: [
      //   MovieDetailBinding(),
      // ],
      binding: BindingsBuilder(() {
        Get.create(() => MovieDetailController());
      }),
    ),
    GetPage(
      name: AppRoute.mainScreen,
      page: () => ShowCaseWidget(
        builder: (context) => HomeScreen(),
      ),
      bindings: [
        BottomNavigationBinding(),
        DashBoardBinding(),
        FavoriteBinding(),
        SearchMovieBinding(),
      ],
    ),
    GetPage(
      name: AppRoute.moreMovieScreen,
      page: () => const MoreMovieScreen(),
      bindings: [
        MoreMovieBinding(),
      ],
    ),
    GetPage(
      name: AppRoute.policyScreen,
      page: () => const PolicyScreen(),
    ),
  ];
}
