import 'package:dio/dio.dart';
import 'package:movie_theater/model/cast_response.dart';
import 'package:movie_theater/model/movie_detail_response.dart';
import 'package:movie_theater/model/movie_response.dart';
import 'package:movie_theater/model/genre_response.dart';
import 'package:movie_theater/model/person_response.dart';

class MovieRepository {
  final String apiKey = 'c6396876f6d8074ed2cd825b08fa8460';
  static String mainUrl = 'https://api.themoviedb.org/3';
  final Dio _dio = Dio();
  var getPopularUrl = '$mainUrl/movie/top_rated';
  var getMoviesUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getGenresUrl = '$mainUrl/genre/movie/list';
  var getPersonsUrl = '$mainUrl/trending/person/week';
  var getUpcomingUrl = '$mainUrl/movie/upcoming';
  var movieUrl = '$mainUrl/movie';

  Future<MovieResponse> getMovies() async {
    var params = {
      'api_key': apiKey,
      'language': 'en-US',
      'page:': 1,
    };
    try {
      Response response =
          await _dio.get(getPopularUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print('Exception occured: $error stackTrace: $stackTrace');
      return MovieResponse.withError('$error');
    }
  }

  Future<MovieResponse> getPlayingMovies() async {
    var params = {
      'api_key': apiKey,
      'language': 'en-US',
      'page:': 1,
    };
    try {
      Response response =
          await _dio.get(getPlayingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print('Exception occured: $error stackTrace: $stackTrace');
      return MovieResponse.withError('$error');
    }
  }

  Future<MovieResponse> getUpcomingMovies() async {
    var params = {
      'api_key': apiKey,
      'language': 'en-US',
      'page:': 1,
    };
    try {
      Response response =
          await _dio.get(getUpcomingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print('Exception occured: $error stackTrace: $stackTrace');
      return MovieResponse.withError('$error');
    }
  }

  Future<GenreResponse> getGenres() async {
    var params = {
      'api_key': apiKey,
      'language': 'en-US',
      'page:': 1,
    };
    try {
      Response response = await _dio.get(getGenresUrl, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print('Exception occured: $error stackTrace: $stackTrace');
      return GenreResponse.withError('$error');
    }
  }

  Future<PersonResponse> getPersons() async {
    var params = {
      'api_key': apiKey,
    };
    try {
      Response response =
          await _dio.get(getPersonsUrl, queryParameters: params);
      return PersonResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print('Exception occured: $error stackTrace: $stackTrace');
      return PersonResponse.withError('$error');
    }
  }

  Future<MovieResponse> getMoviesByGenre(int id) async {
    var params = {
      'api_key': apiKey,
      'language': 'en-US',
      'page:': 1,
      'with_genres': id,
    };
    try {
      Response response = await _dio.get(getMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print('Exception occured: $error stackTrace: $stackTrace');
      return MovieResponse.withError('$error');
    }
  }

  Future<MovieDetailResponse> getMovieDetail(int id) async {
    var params = {
      'api_key': apiKey,
      'language': 'en-US',
    };
    try {
      Response response =
          await _dio.get(movieUrl + '/$id', queryParameters: params);
      return MovieDetailResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print('Exception occured: $error stackTrace: $stackTrace');
      return MovieDetailResponse.withError('$error');
    }
  }

  Future<CastResponse> getCasts(int id) async {
    var params = {
      'api_key': apiKey,
      'language': 'en-US',
    };
    try {
      Response response = await _dio.get(movieUrl + '/$id' + '/credits',
          queryParameters: params);
      return CastResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print('Exception occured: $error stackTrace: $stackTrace');
      return CastResponse.withError('$error');
    }
  }
}
