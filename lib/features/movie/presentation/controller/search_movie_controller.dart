import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:vie_flix/features/movie/domain/entity/feature_movie_entity.dart';
import 'package:vie_flix/features/movie/domain/usecase/movie/get_list_search_movie_usecase.dart';

class SearchMovieController extends GetxController {
  final GetListSearchMovieUsecase getListSearchMovieUsecase =
      GetIt.instance<GetListSearchMovieUsecase>();

  final searchText = ''.obs;
  final isFocused = false.obs;
  final textController = TextEditingController();
  final focusNode = FocusNode();
  final isLoading = RxBool(false);
  Timer? _debounce;
  RxList<FeatureMovieEntity> searchList = <FeatureMovieEntity>[].obs;

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
          _getListSearch(value);
        });
      };

  Future<void> _getListSearch(String value) async {
    try {
      isLoading.value = true;
      searchList.clear(); // Clear old results

      final futureKK = getListSearchMovieUsecase.call(source: 'KK', key: value);
      final futureNC = getListSearchMovieUsecase.call(source: 'NC', key: value);

      final results = await Future.wait([futureKK, futureNC]);
      final kkResults = results[0];
      final ncResults = results[1];

      List<FeatureMovieEntity> kkMovies = [];
      List<FeatureMovieEntity> ncMovies = [];

      kkResults.fold(
        (l) {
          log('Error in KK results: $l');
        },
        (r) {
          kkMovies = r;
        },
      );

      ncResults.fold(
        (l) {
          log('Error in NC results: $l');
        },
        (r) {
          ncMovies = r;
        },
      );

      // Interleave results
      final List<FeatureMovieEntity> interleavedList = [];
      final int maxLength =
          kkMovies.length > ncMovies.length ? kkMovies.length : ncMovies.length;

      for (int i = 0; i < maxLength; i++) {
        if (i < kkMovies.length) {
          interleavedList.add(kkMovies[i]);
        }
        if (i < ncMovies.length) {
          interleavedList.add(ncMovies[i]);
        }
      }

      // Update searchList with interleaved results
      searchList.value = interleavedList;
      log('Search results: ${searchList.length}');
    } catch (e) {
      log('Error getting search results: $e');
      searchList.clear();
    } finally {
      isLoading.value = false;
    }
  }

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
