import 'dart:convert';
import 'dart:developer';

import 'package:vie_flix/core/constant/constants.dart';
import 'package:vie_flix/core/error/exceptions.dart';
import 'package:vie_flix/features/movie/data/model/request_model/feature_movie_model.dart';
import 'package:http/http.dart' as http;

import 'package:vie_flix/features/movie/data/model/request_model/movie_detail_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<FeatureMovieModel>> getListFeatureMovie({required String link});

  Future<MovieDetailModel> getMovieDetail({
    required String slug,
    required String source,
  });

  Future<List<FeatureMovieModel>> getListSearchMovie(
      {required String path, required int limit, required int page});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  @override
  Future<List<FeatureMovieModel>> getListFeatureMovie(
      {required String link}) async {
    log('link: $link');
    try {
      final response = await http.get(Uri.parse(link));
      if (response.statusCode == 200) {
        final items = jsonDecode(response.body)['items'];
        if (items != null && items is List) {
          return items.map((json) => FeatureMovieModel.fromJson(json)).toList();
        }
        final itemsKKphim = jsonDecode(response.body)['data']['items'];
        if (itemsKKphim != null && itemsKKphim is List) {
          return itemsKKphim
              .map((json) => FeatureMovieModel.fromJson(json))
              .toList();
        }
        throw ClientException();
      } else {
        throw ServerException();
      }
    } catch (e, stackTracec) {
      log('$e = $stackTracec');
      throw ClientException();
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetail({
    required String slug,
    required String source,
  }) async {
    try {
      log('source: $source');
      String endPoint = '';
      if (source == 'KK') {
        endPoint = 'https://phimapi.com/phim/';
      } else if (source == 'NC') {
        endPoint = 'https://phim.nguonc.com/api/film/';
      } else {
        endPoint = 'https://ophim1.com/phim/';
      }

      final response = await http.get(Uri.parse('$endPoint$slug'));
      log('status: ${response.statusCode} = $endPoint$slug');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log("1");
        if (data != null) {
          log("2");
          return MovieDetailModel.fromJson(data);
        }
        throw ClientException();
      } else {
        throw ServerException();
      }
    } catch (e, stackTracec) {
      log('$e = $stackTracec');
      throw ClientException();
    }
  }

  @override
  Future<List<FeatureMovieModel>> getListSearchMovie(
      {required String path, required int limit, required int page}) async {
    final response = await http.get(Uri.parse(
        '${Constants.baseUrlV1API}danh-sach/$path?page=$page&limit=$limit'));
    if (response.statusCode == 200) {
      final items = jsonDecode(response.body)['data']['items'];

      if (items is List) {
        return items.map((json) => FeatureMovieModel.fromJson(json)).toList();
      }
      throw ClientException();
    } else {
      throw ServerException();
    }
  }
}
