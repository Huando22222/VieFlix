// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names
import 'package:flutter/material.dart';

class ScrollColumPaddingWidget extends StatelessWidget {
  final CrossAxisAlignment? crossAxisAlignment;
  final List<Widget> children;
  final double? paddingTop;
  final double? paddingHorizontal;
  final double? paddingBottom;
  final ScrollController? controller;
  const ScrollColumPaddingWidget({
    super.key,
    this.crossAxisAlignment,
    required this.children,
    this.paddingTop,
    this.paddingBottom,
    this.paddingHorizontal,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final dv = MediaQuery.of(context);
    return SingleChildScrollView(
      controller: controller,
      padding: EdgeInsets.only(
        top: paddingTop != null
            ? (dv.padding.top + paddingTop!)
            : (dv.padding.top + 10),
        bottom: paddingBottom != null
            ? (dv.padding.bottom + paddingBottom!)
            : (dv.padding.bottom + 10),
        left: paddingHorizontal ?? 10,
        right: paddingHorizontal ?? 10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
