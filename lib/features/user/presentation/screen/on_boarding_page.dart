import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:vie_flix/core/data/category.dart';
import 'package:vie_flix/features/user/data/data_sources/local/database_data_source.dart';
import 'package:vie_flix/features/user/presentation/controller/filter_controller.dart';
import 'package:vie_flix/common/styles/app_color.dart';
import 'package:vie_flix/config/routes/app_route.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  final FilterController filterController = Get.find<FilterController>();
  void _onIntroEnd() {
    Get.toNamed(AppRoute.mainScreen);
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/images/cinema.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
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
      showSkipButton: true,
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
      // dotsContainerDecorator: const ShapeDecoration(
      //   color: Colors.black87,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
      //   ),
      // ),
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: _buildImage('cinema.png', 100),
          ),
        ),
      ),

      pages: [
        PageViewModel(
          title: "Fractional shares",
          body:
              "Instead of having to buy an entire share, invest any amount you want.",
          image: _buildImage('img1.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Full Screen Page",
          body:
              "Pages can be full screen as well.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
          image: _buildFullscreenImage(),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            bodyFlex: 2,
            imageFlex: 3,
            safeArea: 100,
          ),
        ),
        PageViewModel(
          title: "Chọn thể loại phim\nbạn yêu thích",
          bodyWidget: Column(
            children: [
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
              Text(
                  "Dựa trên những lựa chọn này để giới thiệu cho bạn những phim mới nhất theo thể loại bạn chọn (có thể thay đổi trong home)"),
            ],
          ),
          decoration: pageDecoration,
        ),
      ],
    );
  }
}
