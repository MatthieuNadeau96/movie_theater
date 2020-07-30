import 'package:flutter/material.dart';
import 'package:movie_theater/bloc/get_movie_detail_bloc.dart';
import 'package:movie_theater/model/movie.dart';
import 'package:movie_theater/model/movie_detail.dart';
import 'package:movie_theater/model/movie_detail_response.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;
  final int movieIndex;

  DetailScreen({Key key, @required this.movie, this.movieIndex})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState(movie, movieIndex);
}

class _DetailScreenState extends State<DetailScreen> {
  final Movie movie;
  final int movieIndex;
  _DetailScreenState(this.movie, this.movieIndex);

  @override
  void initState() {
    super.initState();
    movieDetailBloc..getMovieDetail(movie.id);
  }

  @override
  void dispose() {
    movieDetailBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return StreamBuilder<MovieDetailResponse>(
            stream: movieDetailBloc.subject.stream,
            builder: (context, AsyncSnapshot<MovieDetailResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return _buildErrorWidget(snapshot.data.error);
                }
                return _buildMovieDetailsWidget(snapshot.data);
              } else if (snapshot.hasError) {
                return _buildErrorWidget(snapshot.error);
              } else {
                return _buildLoadingWidget();
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('Error occured: $error')],
      ),
    );
  }

  Widget _buildMovieDetailsWidget(MovieDetailResponse data) {
    MovieDetail movieDetails = data.movieDetail;
    final Size deviceSize = MediaQuery.of(context).size;
    return Container(
      child: Center(
        child: Text(movie.title),
      ),
    );
  }
}
