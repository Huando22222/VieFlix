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

  bool isShowcaseTriggeredMovieDetail = false;
  bool isShowcaseTriggeredDashboard = false;

  @override
  void onInit() {
    super.onInit();
    // loadSettings();
    Get.put(FilterController());
  }

  Future<void> loadSettings() async {
    isLoadingSetting.value = true;
    final pref = await SharedPreferences.getInstance();

    bool isShowcaseTriggered = pref.getBool('isShowcaseTriggered') ?? true;
    isShowcaseTriggeredMovieDetail = isShowcaseTriggered;
    isShowcaseTriggeredDashboard = isShowcaseTriggered;
    //
    isShowIntro.value = pref.getBool('isShowIntro') ?? true;
    isDarkTheme.value = pref.getBool('isDarkTheme') ?? true;
    Get.changeTheme(isDarkTheme.value ? AppTheme.dark : AppTheme.light);
    isExpandedSetting.value = pref.getBool('isExpandedSetting') ?? false;
    isAutoPlayVideo.value = pref.getBool('isAutoPlayVideo') ?? false;
    isShowTitleMovie.value = pref.getBool('isShowTitleMovie') ?? false;
    isShowGridEpisodes.value = pref.getBool('isShowGridEpisodes') ?? true;
    isLoadingSetting.value = false;
  }

  void changeShowcaseTriggered({required bool value}) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('isShowcaseTriggered', value);
  }

  void changeTheme() async {
    final pref = await SharedPreferences.getInstance();
    Get.changeTheme(isDarkTheme.value ? AppTheme.light : AppTheme.dark);
    isDarkTheme.value = !isDarkTheme.value;
    log(isDarkTheme.value.toString());
    await pref.setBool('isDarkTheme', isDarkTheme.value);
  }

  void changeShowIntro() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('isShowIntro', !isShowIntro.value);
    isShowIntro.value = !isShowIntro.value;
  }

  void changeExpandedSetting() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('isExpandedSetting', !isExpandedSetting.value);
    isExpandedSetting.value = !isExpandedSetting.value;
  }

  void changeAutoPlayVideo() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('isAutoPlayVideo', !isAutoPlayVideo.value);
    isAutoPlayVideo.value = !isAutoPlayVideo.value;
  }

  void changeShowTitleMovie() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('isShowTitleMovie', !isShowTitleMovie.value);
    isShowTitleMovie.value = !isShowTitleMovie.value;
  }

  void changeShowGridEpisodes() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('isShowGridEpisodes', !isShowGridEpisodes.value);
    isShowGridEpisodes.value = !isShowGridEpisodes.value;
  }
}
