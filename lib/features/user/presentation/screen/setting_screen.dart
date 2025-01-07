import 'package:flutter/material.dart';
import 'package:vie_flix/common/widget/scroll_colum_padding_widget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: ScrollColumPaddingWidget(
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  const Text("data"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
