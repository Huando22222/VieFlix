import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:vie_flix/core/data/category.dart';
import 'package:vie_flix/features/user/presentation/controller/app_setting_controller.dart';
import 'package:vie_flix/features/user/presentation/controller/filter_controller.dart';
import 'package:vie_flix/common/styles/app_color.dart';
import 'package:vie_flix/config/routes/app_route.dart';

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({super.key});

  final introKey = GlobalKey<IntroductionScreenState>();

  final FilterController filterController = Get.find<FilterController>();

  final AppSettingController appSettingController =
      Get.find<AppSettingController>();

  void _onIntroEnd() {
    filterController.updateCategory();
    Get.toNamed(AppRoute.mainScreen);
    appSettingController.changeShowIntro();
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    var pageDecoration = PageDecoration(
      titleTextStyle: Theme.of(context).textTheme.headlineMedium!,
      bodyTextStyle: Theme.of(context).textTheme.titleMedium!,
      bodyAlignment: Alignment.center,
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Theme.of(context).colorScheme.surface,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Theme.of(context).colorScheme.surface,
      allowImplicitScrolling: true,
      onDone: () => _onIntroEnd(),
      onSkip: () => _onIntroEnd(),
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: DotsDecorator(
        activeColor: Theme.of(context).colorScheme.primary,
        size: const Size(10.0, 10.0),
        color: Theme.of(context).colorScheme.secondary,
        activeSize: const Size(22.0, 10.0),
        activeShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Kho phim khổng lồ, đa dạng thể loại, cập nhật liên tục.",
          body: " ",
          image: _buildImage('Vie.png'),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            titleTextStyle: Theme.of(context).textTheme.headlineMedium,
            bodyTextStyle: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        PageViewModel(
          title: "Chọn thể loại phim\nbạn yêu thích",
          bodyWidget: Column(
            children: [
              Obx(
                () {
                  return Wrap(
                    children: [
                      ...List.generate(
                        categories.length,
                        (index) {
                          final isSelected =
                              filterController.fav.contains(categories[index]);
                          return GestureDetector(
                            onTap: () {
                              filterController
                                  .onSelectFavorite(categories[index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.transparent,
                                border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    categories[index].name,
                                    style: isSelected
                                        ? Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: AppColor.darkText)
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        growable: true,
                      ),
                    ],
                  );
                },
              ),
              const Text(
                  "Dựa trên những lựa chọn này để giới thiệu cho bạn những phim mới nhất theo thể loại bạn chọn (có thể thay đổi trong Cài đặt)"),
            ],
          ),
          decoration: pageDecoration,
        ),
      ],
    );
  }
}
