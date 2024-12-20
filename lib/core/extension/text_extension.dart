import 'package:flutter/material.dart';
import 'package:vie_flix/core/constant/constants.dart';

//https://www.youtube.com/watch?v=rPE0aDGsOvE

extension TextColorExtension on ThemeData {
  Color get lightTextColor =>
      brightness == Brightness.dark ? Colors.white : Colors.black;
}

extension UrlExtension on String {
  String get fullImageUrl {
    if (startsWith('http://') || startsWith('https://')) {
      return this;
    }

    return '${Constants.baseUrlPoster}$this';
  }
}
