import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vie_flix/config/routes/app_route.dart';
import 'package:vie_flix/features/user/presentation/controller/app_setting_controller.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppSettingController appSettingController =
        Get.find<AppSettingController>();
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            children: [
              // Logo
              Image.asset(
                'assets/images/Vie.png',
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.12,
              ),
              const SizedBox(height: 24),
              // Application Section
              _buildSession(
                context: context,
                title: 'Ứng dụng',
                children: [
                  Obx(() => _buildExpandableItem(
                        context: context,
                        title: 'Cài đặt',
                        iconPath: 'assets/images/fav_icon.png',
                        isExpanded:
                            appSettingController.isExpandedSetting.value,
                        onTap: appSettingController.changeExpandedSetting,
                        children: [
                          _buildSwitchTile(
                            context: context,
                            title: 'Chế độ tối',
                            value: appSettingController.isDarkTheme.value,
                            onChanged: (value) {
                              appSettingController.changeTheme();
                            },
                          ),
                          _buildSwitchTile(
                            context: context,
                            title: 'Hiện tên phim',
                            value: appSettingController.isShowTitleMovie.value,
                            onChanged: (value) {
                              appSettingController.changeShowTitleMovie();
                            },
                          ),
                          _buildSwitchTile(
                            context: context,
                            title: 'Tự động phát video',
                            value: appSettingController.isAutoPlayVideo.value,
                            onChanged: (value) {
                              appSettingController.changeAutoPlayVideo();
                            },
                          ),
                          ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            title: Text(
                              'Chọn lại thể loại đề xuất',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            trailing: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16),
                            onTap: () {
                              appSettingController.changeShowIntro();
                              Get.offAllNamed(AppRoute.onBoardingScreen);
                            },
                          ),
                        ],
                      )),
                ],
              ),
              const SizedBox(height: 16),
              // About Section
              _buildSession(
                context: context,
                title: 'Giới thiệu',
                children: [
                  _buildItem(
                    context: context,
                    title: 'Điều khoản sử dụng & Bảo mật',
                    iconPath: 'assets/images/copyright_icon.png',
                    onTap: () => Get.toNamed(AppRoute.policyScreen),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSession({
    required BuildContext context,
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildExpandableItem({
    required BuildContext context,
    required String title,
    required String iconPath,
    required bool isExpanded,
    required VoidCallback onTap,
    List<Widget>? children,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          leading: Image.asset(
            iconPath,
            height: 24,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          trailing: Icon(
            isExpanded
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          onTap: onTap,
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Column(children: children ?? []),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }

  Widget _buildItem({
    required BuildContext context,
    required String title,
    required String iconPath,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      leading: Image.asset(
        iconPath,
        height: 24,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required BuildContext context,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
