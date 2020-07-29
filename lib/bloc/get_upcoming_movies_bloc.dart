import 'package:movie_theater/model/movie_response.dart';
import 'package:movie_theater/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class UpcommingListBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getMovies() async {
    MovieResponse response = await _repository.getUpcomingMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final upcommingMoviesBloc = UpcommingListBloc();
