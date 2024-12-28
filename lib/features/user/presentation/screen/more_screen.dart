import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vie_flix/config/routes/app_route.dart';
import 'package:vie_flix/features/user/presentation/controller/theme_controller.dart';
import 'package:vie_flix/common/widget/Scroll_Colum_padding_widget.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dv = MediaQuery.of(context);
    return Center(
      child: ScrollColumPaddingWidget(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Vie\nFlix"),
          _buildSession(
            name: 'Ứng dụng',
            children: [
              _buildItem(
                name: 'Gợi ý phim',
                path: 'assets/images/fav_icon.png',
                onTap: () {},
              ),
              Divider(),
              _buildItem(
                name: 'Playlist',
                path: 'assets/images/playlist_icon.png',
                onTap: () {},
              ),
              Divider(),
              _buildItem(
                name: 'Góp ý về ứng dụng',
                path: 'assets/images/unity_icon.png',
                onTap: () {},
              ),
              Divider(),
              _buildItem(
                name: 'Settings',
                path: 'assets/images/fav_icon.png',
                onTap: () {
                  Get.toNamed(AppRoute.settingScreen);
                },
              )
            ],
          ),
          _buildSession(
            name: 'Giới thiệu',
            children: [
              _buildItem(
                name: 'Về VieFlix',
                path: 'assets/images/info_icon.png',
                onTap: () {},
              ),
              Divider(),
              _buildItem(
                name: 'Điều khoản sử dụng & Bảo mật',
                path: 'assets/images/copyright_icon.png',
                onTap: () {},
              ),
            ],
          ),
          Switch(
            value: true,
            onChanged: (value) {
              Get.find<ThemeController>().changeTheme();
            },
          )
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
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.all(Radius.circular(10)),
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
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            path,
            height: 34,
          ),
          Text(name),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
          )
        ],
      ),
    );
  }
}
