class HomeEndpoints {
  static const String popularMoviesPath = '/movie/popular';
  static String movieDetailsPath({required int movieId}) => '/movie/$movieId';
}
