import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vie_flix/features/user/presentation/controller/theme_controller.dart';
import 'package:vie_flix/common/styles/app_theme.dart';
import 'package:vie_flix/features/movie/presentation/binding/root_binding.dart';
import 'package:vie_flix/config/routes/app_page.dart';
import 'package:vie_flix/config/routes/app_route.dart';
import 'package:vie_flix/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.onBoardingScreen,
      getPages: AppPage.routes,
      initialBinding: RootBinding(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
    );
  }
}
