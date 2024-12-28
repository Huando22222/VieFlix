import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchMovieController extends GetxController {
  final searchText = ''.obs;
  final isFocused = false.obs;
  final textController = TextEditingController();
  final focusNode = FocusNode();
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });
  }

  Function(String)? get onChanged => (value) {
        searchText.value = value;
        if (_debounce?.isActive ?? false) _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 1500), () {
          // Call your search endpoint here
          log("Searching for: $value");
        });
      };

  void clearSearch() {
    textController.clear();
    searchText.value = '';
  }

  @override
  void onClose() {
    textController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
