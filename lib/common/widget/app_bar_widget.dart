import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const AppBarWidget({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // automaticallyImplyLeading: false,
      title: Text(title ?? 'VieFlix'),
      centerTitle: true,
      actions: [
        // DrawerWidget(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
