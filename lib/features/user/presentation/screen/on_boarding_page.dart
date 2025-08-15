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

    return SafeArea(
      child: IntroductionScreen(
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
            title: "",
            body: " ",
            image: _buildImage('Vie.png'),
            decoration: pageDecoration.copyWith(
              imageFlex: 2,
              bodyFlex: 1,
              contentMargin: const EdgeInsets.symmetric(horizontal: 16),
              titleTextStyle: Theme.of(context).textTheme.headlineMedium,
              bodyTextStyle: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          PageViewModel(
            title: "Chọn thể loại phim yêu thích",
            bodyWidget: SafeArea(
              child: Column(
                children: [
                  Obx(
                    () => Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: List.generate(
                        categories.length,
                        (index) {
                          final isSelected =
                              filterController.fav.contains(categories[index]);
                          return ChoiceChip(
                            label: Text(
                              categories[index].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: isSelected
                                        ? Colors.white
                                        : Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            selected: isSelected,
                            selectedColor:
                                Theme.of(context).colorScheme.primary,
                            backgroundColor: AppColor.lightBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.5)),
                            ),
                            onSelected: (_) => filterController
                                .onSelectFavorite(categories[index]),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Chúng tôi sẽ đề xuất các bộ phim mới nhất dựa trên lựa chọn của bạn (có thể thay đổi trong Cài đặt).",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            decoration: pageDecoration.copyWith(
              bodyFlex: 3,
              imageFlex: 0,
            ),
          ),
        ],
      ),
    );
  }
}
