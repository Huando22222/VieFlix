import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vie_flix/config/routes/app_route.dart';
import 'package:vie_flix/features/user/presentation/controller/app_setting_controller.dart';
import 'package:vie_flix/common/widget/Scroll_Colum_padding_widget.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppSettingController appSettingController =
        Get.find<AppSettingController>();
    return Center(
      child: ScrollColumPaddingWidget(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Vie.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.15,
          ),

          // _buildSession(
          //   name: 'Ứng dụng',
          //   children: [
          //     _buildItem(
          //       name: 'Gợi ý phim',
          //       path: 'assets/images/fav_icon.png',
          //       onTap: () {},
          //     ),
          //     Divider(),
          //     _buildItem(
          //       name: 'Playlist',
          //       path: 'assets/images/playlist_icon.png',
          //       onTap: () {},
          //     ),
          //     Divider(),
          //     _buildItem(
          //       name: 'Góp ý về ứng dụng',
          //       path: 'assets/images/unity_icon.png',
          //       onTap: () {},
          //     ),
          //   ],
          // ),
          _buildSession(
            name: 'Ứng dụng',
            children: [
              Obx(
                () {
                  return _buildItem(
                    name: 'Settings',
                    path: 'assets/images/fav_icon.png',
                    icon: appSettingController.isExpandedSetting.value
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    onTap: () {
                      appSettingController.changeExpandedSetting();
                    },
                    isExpanded: appSettingController.isExpandedSetting.value,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    "Dark mode",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  trailing: Switch(
                                    value:
                                        appSettingController.isDarkTheme.value,
                                    onChanged: (value) {
                                      appSettingController.changeTheme();
                                    },
                                  ),
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    "Hiện tên phim",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  trailing: Switch(
                                    value: appSettingController
                                        .isShowTitleMovie.value,
                                    onChanged: (value) {
                                      appSettingController
                                          .changeShowTitleMovie();
                                    },
                                  ),
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    "tự động phát video",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  trailing: Switch(
                                    value: appSettingController
                                        .isAutoPlayVideo.value,
                                    onChanged: (value) {
                                      appSettingController
                                          .changeAutoPlayVideo();
                                    },
                                  ),
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    "Chọn lại thể loại đề xuất",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  onTap: () {
                                    appSettingController.changeShowIntro();
                                    Get.offAllNamed(AppRoute.onBoardingScreen);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              )
            ],
          ),
          _buildSession(
            name: 'Giới thiệu',
            children: [
              _buildItem(
                name: 'Điều khoản sử dụng & Bảo mật',
                path: 'assets/images/copyright_icon.png',
                icon: Icons.arrow_forward_ios_rounded,
                onTap: () {
                  Get.toNamed(AppRoute.policyScreen);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSession({required String name, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.5)),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [...children],
          ),
        ),
      ],
    );
  }

  Widget _buildItem({
    required String name,
    required String path,
    VoidCallback? onTap,
    bool? isExpanded,
    IconData? icon,
    List<Widget>? children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Image.asset(
                path,
                height: 34,
                color: Colors.white,
              ),
              Text(name),
              const Spacer(),
              Icon(
                icon,
                size: 14,
              )
            ],
          ),
        ),
        if (isExpanded != null && isExpanded && children != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Divider(),
                ...children,
              ],
            ),
          ),
      ],
    );
  }
}
