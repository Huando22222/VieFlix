import 'package:get/get.dart';
import 'package:vie_flix/common/styles/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  RxBool isDarkTheme = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  void changeTheme() async {
    Get.changeTheme(isDarkTheme.value ? AppTheme.light : AppTheme.dark);
    isDarkTheme.value = !isDarkTheme.value;
    await _saveTheme(isDarkTheme.value);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkTheme') ?? false;
    isDarkTheme.value = isDark;
    Get.changeTheme(isDark ? AppTheme.dark : AppTheme.light);
  }

  Future<void> _saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isDark);
  }
}
