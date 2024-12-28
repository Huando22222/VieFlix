import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vie_flix/features/movie/presentation/screen/dash_board_screen.dart';
import 'package:vie_flix/features/movie/presentation/screen/favorite_screen.dart';
import 'package:vie_flix/features/user/presentation/screen/more_screen.dart';
import 'package:vie_flix/features/movie/presentation/screen/search_screen.dart';

class BottomNavigationController extends GetxController {
  var currentIndex = 0.obs;

  final pages = <Widget>[
    const DashBoardScreen(),
    const SearchScreen(),
    const FavoriteScreen(),
    const MoreScreen(),
  ];
  final itemBottomNavigation = [
    {
      'name': 'home',
      'pathIcon': 'assets/images/home_icon.png',
    },
    {
      'name': 'search',
      'pathIcon': 'assets/images/search_icon.png',
    },
    {
      'name': 'favorite',
      'pathIcon': 'assets/images/playlist_icon.png',
    },
    {
      'name': 'more',
      'pathIcon': 'assets/images/app_icon.png',
    },
  ];
  void changeTab({required int index}) {
    currentIndex.value = index;
  }
}
