import 'dart:convert';
import 'dart:developer';

import 'package:vie_flix/core/constant/constants.dart';
import 'package:vie_flix/core/error/exceptions.dart';
import 'package:vie_flix/features/movie/data/model/kkphim/request/latest_movie_model.dart';
import 'package:http/http.dart' as http;

import 'package:vie_flix/features/movie/data/model/kkphim/request/movie_detail_model.dart';
import 'package:vie_flix/features/movie/data/model/kkphim/request/search_movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<LatestMovieModel>> getListLatestMovie(
      {required int limit, required int page});

  Future<MovieDetailModel> getMovieDetail({required String slug});

  Future<List<SearchMovieModel>> getListSearchMovie(
      {required String path, required int limit, required int page});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  @override
  Future<List<LatestMovieModel>> getListLatestMovie(
      {required int limit, required int page}) async {
    final response = await http.get(Uri.parse(
        '${Constants.baseUrl}danh-sach/phim-moi-cap-nhat?limit=$limit&page=$page'));
    if (response.statusCode == 200) {
      final items = jsonDecode(response.body)['items'];
      if (items is List) {
        return items.map((json) => LatestMovieModel.fromJson(json)).toList();
      }
      throw ClientException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetail({required String slug}) async {
    final response =
        await http.get(Uri.parse('${Constants.baseUrl}phim/$slug'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data != null) {
        try {
          return MovieDetailModel.fromJson(data);
        } catch (e, stackTrace) {
          log('stackTrace: $stackTrace ========= $e');
        }
      }
      throw ClientException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SearchMovieModel>> getListSearchMovie(
      {required String path, required int limit, required int page}) async {
    final response = await http.get(Uri.parse(
        '${Constants.baseUrlV1API}danh-sach/$path?page=$page&limit=$limit'));
    if (response.statusCode == 200) {
      final items = jsonDecode(response.body)['data']['items'];

      if (items is List) {
        return items.map((json) => SearchMovieModel.fromJson(json)).toList();
      }
      throw ClientException();
    } else {
      throw ServerException();
    }
  }
}
