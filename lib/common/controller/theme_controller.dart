import 'package:get/get.dart';
import 'package:vie_flix/common/styles/app_theme.dart';

class ThemeController extends GetxController {
  RxBool isDarkTheme = false.obs;
  void changeTheme() {
    Get.changeTheme(isDarkTheme.value ? AppTheme.light : AppTheme.dark);
    isDarkTheme.value = !isDarkTheme.value;
  }
}
