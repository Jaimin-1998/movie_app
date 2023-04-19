class API {
  static const String baseUrl = 'https://api.themoviedb.org/3/';

  static const apiKey = '8de41f68732f5b052d5af373d5fd0f53';
  static const imageBasePath = 'https://image.tmdb.org/t/p/w500/';

  static const String trendingMovieAPI = '${baseUrl}movie/top_rated?api_key=$apiKey';
  static const String searchMovieAPI = '${baseUrl}search/movie?api_key=$apiKey';
  static const String genreAPI = '${baseUrl}genre/movie/list?api_key=$apiKey&language=en-US';
}