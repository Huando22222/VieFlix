import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vie_flix/common/styles/app_theme.dart';
import 'package:vie_flix/features/user/presentation/controller/filter_controller.dart';

class AppSettingController extends GetxController {
  RxBool isLoadingSetting = false.obs;

  RxBool isExpandedSetting = false.obs;
  RxBool isShowIntro = false.obs;
  RxBool isAutoPlayVideo = false.obs;
  RxBool isShowGridEpisodes = false.obs;
  RxBool isShowTitleMovie = false.obs;
  RxBool isDarkTheme = false.obs;

  @override
  void onInit() {
    super.onInit();
    // loadSettings();

    Get.put(FilterController());
  }

  Future<void> loadSettings() async {
    isLoadingSetting.value = true;
    final prefs = await SharedPreferences.getInstance();

    isShowIntro.value = prefs.getBool('isShowIntro') ?? true;
    log(prefs.getBool('isShowIntro').toString());
    isDarkTheme.value = prefs.getBool('isDarkTheme') ?? false;
    Get.changeTheme(isDarkTheme.value ? AppTheme.dark : AppTheme.light);
    isExpandedSetting.value = prefs.getBool('isExpandedSetting') ?? false;
    isAutoPlayVideo.value = prefs.getBool('isAutoPlayVideo') ?? false;
    isShowTitleMovie.value = prefs.getBool('isShowTitleMovie') ?? false;
    isShowGridEpisodes.value = prefs.getBool('isShowGridEpisodes') ?? true;
    isLoadingSetting.value = false;
  }

  void changeTheme() async {
    final prefs = await SharedPreferences.getInstance();
    Get.changeTheme(isDarkTheme.value ? AppTheme.light : AppTheme.dark);
    isDarkTheme.value = !isDarkTheme.value;
    await prefs.setBool('isDarkTheme', isDarkTheme.value);
  }

  void changeShowIntro() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isShowIntro', !isShowIntro.value);
    isShowIntro.value = !isShowIntro.value;
  }

  void changeExpandedSetting() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isExpandedSetting', !isExpandedSetting.value);
    isExpandedSetting.value = !isExpandedSetting.value;
  }

  void changeAutoPlayVideo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAutoPlayVideo', !isAutoPlayVideo.value);
    isAutoPlayVideo.value = !isAutoPlayVideo.value;
  }

  void changeShowTitleMovie() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isShowTitleMovie', !isShowTitleMovie.value);
    isShowTitleMovie.value = !isShowTitleMovie.value;
  }

  void changeShowGridEpisodes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isShowGridEpisodes', !isShowGridEpisodes.value);
    isShowGridEpisodes.value = !isShowGridEpisodes.value;
  }
}
