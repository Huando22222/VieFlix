import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vie_flix/features/user/presentation/controller/app_setting_controller.dart';
import 'package:vie_flix/common/styles/app_theme.dart';
import 'package:vie_flix/features/movie/presentation/binding/root_binding.dart';
import 'package:vie_flix/config/routes/app_page.dart';
import 'package:vie_flix/config/routes/app_route.dart';
import 'package:vie_flix/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  final appSettingController = Get.put(AppSettingController());
  await appSettingController.loadSettings();
  final initialRoute = appSettingController.isShowIntro.value
      ? AppRoute.onBoardingScreen
      : AppRoute.mainScreen;
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then(
    (_) {
      runApp(MyApp(initialRoute: initialRoute));
    },
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    final appSettingController = Get.find<AppSettingController>();
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        getPages: AppPage.routes,
        initialBinding: RootBinding(),
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: appSettingController.isDarkTheme.value
            ? ThemeMode.dark
            : ThemeMode.light,
      ),
    );
  }
}
