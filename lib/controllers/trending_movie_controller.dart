import 'package:movie/helper/loader.dart';
import 'package:movie/models/genre_model.dart';
import 'package:movie/models/trending_movie_model.dart';
import 'package:movie/repository/genre_repository.dart';
import 'package:movie/repository/trending_movie_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class TrendingMovieController extends ControllerMVC {
  List<TrendingMovieResult>? results = [];
  List<TrendingMovieResult>? resultsMultipleData = [];
  int? totalPages;
  int? currentPage;
  List<Genre>? genres = [];

  /// Trending Movie API Controller
  Future<void> getTrendingMovieAPI({int? page}) async {
    showLoader();
    await getTrendingMovieRepository(page: page).then((value) {
      if (value != null) {
        setState(() {
          results = value.results!;
          totalPages = value.totalPages!;
          currentPage = value.page!;
          for (int i = 0; i < value.results!.length; i++) {
            resultsMultipleData!.add(value.results![i]);
          }
        });
      }
    }).catchError((e) {
      hideLoader();
      print('catchError ->${e.toString()}');
    }).whenComplete(() {
      hideLoader();
    });
  }

  /// Search Movie API Controller
  Future<void> getSearchAPI(String text, {int? page}) async {
    showLoader();
    await getSearchRepository(text, page: page).then((value) {
      if (value != null) {
        setState(() {
          results = value.results!;
          totalPages = value.totalPages!;
          currentPage = value.page!;
          for (int i = 0; i < value.results!.length; i++) {
            resultsMultipleData!.add(value.results![i]);
          }
        });

      }
    }).catchError((e) {
      hideLoader();
      print('catchError ->${e.toString()}');
    }).whenComplete(() {
      hideLoader();
    });
  }

  /// Genre API Controller
  Future<void> getGenreAPI() async {
    showLoader();
    await getGenreRepository().then((value) {
      if (value != null) {
        setState(() {
          genres = value.genres!;
        });
      }
    }).catchError((e) {
      hideLoader();
      print('catchError ->${e.toString()}');
    }).whenComplete(() {
      hideLoader();
    });
  }
}