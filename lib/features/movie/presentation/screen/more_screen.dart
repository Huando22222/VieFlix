import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vie_flix/common/controller/theme_controller.dart';
import 'package:vie_flix/common/widget/Scroll_Colum_padding_widget.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollColumPaddingWidget(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            Get.find<ThemeController>().changeTheme();
            log(Get.find<ThemeController>().isDarkTheme.value.toString());
          },
          child: Text("data"),
        ),
        Text("data"),
      ],
    );
  }
}
