import 'package:dio/dio.dart';
import 'package:movie/helper/api.dart';
import 'package:movie/models/trending_movie_model.dart';

Dio dio = Dio();

/// Trending Movie API Call
Future<TrendingMovieModel?> getTrendingMovieRepository({int? page = 1}) async {
  try {
    Response response;
    response = await dio.get('${API.trendingMovieAPI}&page=$page',
        options: Options(headers: {"Content-Type": 'application/json'}));
    if (response.statusCode == 200) {
      TrendingMovieModel trendingMovieModel =
          TrendingMovieModel.fromJson(response.data);
      return trendingMovieModel;
    } else {
      throw Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}

/// Search Movie API Call
Future<TrendingMovieModel?> getSearchRepository(String text, {int? page = 1}) async {
  try {
    Response response;
    response = await dio.get('${API.searchMovieAPI}&page=$page&&query=$text',
        options: Options(headers: {"Content-Type": 'application/json'}));
    if (response.statusCode == 200) {
      print('SEarch response: ${response.data}');
      TrendingMovieModel trendingMovieModel =
      TrendingMovieModel.fromJson(response.data);
      return trendingMovieModel;
    } else {
      throw Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}
