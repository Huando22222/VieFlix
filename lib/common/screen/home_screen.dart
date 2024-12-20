import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vie_flix/common/controller/bottom_navigation_controller.dart';
import 'package:vie_flix/common/controller/theme_controller.dart';
import 'package:vie_flix/common/styles/app_color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dv = MediaQuery.of(context);
    final BottomNavigationController bottomNavigationController =
        Get.find<BottomNavigationController>();
    final ThemeController themeController = Get.find<ThemeController>();
    return Scaffold(
      extendBody: true,
      body: Obx(
        () {
          return IndexedStack(
            index: bottomNavigationController.currentIndex.value,
            children: bottomNavigationController.pages,
          );
        },
      ),
      bottomNavigationBar: Obx(
        () {
          return Container(
            height: dv.size.height * 0.1,
            padding: EdgeInsets.only(
              bottom: dv.padding.bottom,
            ),
            decoration: BoxDecoration(
                color: themeController.isDarkTheme.value
                    ? AppColor.darkBackground
                    : AppColor.lightBackground,
                boxShadow: [
                  BoxShadow(
                    color: (themeController.isDarkTheme.value
                            ? AppColor.darkPrimary
                            : AppColor.lightPrimary)
                        .withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, -3),
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (var i = 0;
                    i < bottomNavigationController.itemBottomNavigation.length;
                    i++)
                  _buildIconNavigation(
                    onTap: () {
                      bottomNavigationController.changeTab(index: i);
                    },
                    isSelected:
                        i == bottomNavigationController.currentIndex.value,
                    name: bottomNavigationController.itemBottomNavigation[i]
                        ['name']!,
                    pathIcon: bottomNavigationController.itemBottomNavigation[i]
                        ['pathIcon']!,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildIconNavigation(
      {required VoidCallback onTap,
      required bool isSelected,
      required String name,
      required String pathIcon}) {
    final ThemeController themeController = Get.find<ThemeController>();
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: isSelected
                      ? (themeController.isDarkTheme.value
                          ? AppColor.darkPrimary.withOpacity(0.3)
                          : AppColor.lightPrimary.withOpacity(0.2))
                      : Colors.transparent,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Image.asset(
                  pathIcon,
                  height: 25,
                  width: 25,
                  color: isSelected
                      ? (themeController.isDarkTheme.value
                          ? AppColor.darkPrimary
                          : AppColor.lightPrimary)
                      : (themeController.isDarkTheme.value
                          ? AppColor.darkText.withOpacity(0.6)
                          : AppColor.lightText.withOpacity(0.6)),
                ),
              ),
            ),
            Text(
              name,
              style: TextStyle(
                color: isSelected
                    ? (themeController.isDarkTheme.value
                        ? AppColor.darkPrimary
                        : AppColor.lightPrimary)
                    : (themeController.isDarkTheme.value
                        ? AppColor.darkText.withOpacity(0.6)
                        : AppColor.lightText.withOpacity(0.6)),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}