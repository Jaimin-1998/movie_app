import 'package:dio/dio.dart';
import 'package:movie/helper/api.dart';
import 'package:movie/models/genre_model.dart';

Dio dio = Dio();

/// Genre API Call
Future<GenreModel?> getGenreRepository() async {
  try {
    Response response;
    response = await dio.get(API.genreAPI);
    if (response.statusCode == 200) {
      GenreModel genreModel =
      GenreModel.fromJson(response.data);
      return genreModel;
    } else {
      throw Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}