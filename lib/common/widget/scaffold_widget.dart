// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:vie_flix/common/widget/app_bar_widget.dart';
import 'package:vie_flix/common/widget/drawer_widget.dart';

class ScaffoldWidget extends StatelessWidget {
  final bool? showDrawer;
  final Widget body;
  const ScaffoldWidget({
    super.key,
    this.showDrawer,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      endDrawer: showDrawer == true
          ? const Drawer(
              child: DrawerWidget(),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: body,
      ),
    );
  }
}
