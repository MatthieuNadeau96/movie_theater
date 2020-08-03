import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:movie_theater/bloc/get_movie_detail_bloc.dart';
import 'package:movie_theater/model/movie.dart';
import 'package:movie_theater/model/movie_detail.dart';
import 'package:movie_theater/model/movie_detail_response.dart';
import 'package:movie_theater/screens/seat_screen.dart';
import 'package:movie_theater/widgets/casts.dart';

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
    super.dispose();
    movieDetailBloc..dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark.withOpacity(0.3),
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).accentColor,
        label: Text(
          'BUY TICKET',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SeatScreen(),
            ),
          );
        },
        icon: Icon(Icons.confirmation_num),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).canvasColor),
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
    String imageUrl = 'https://image.tmdb.org/t/p/original/';
    return SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl + movie.poster),
                fit: BoxFit.fill,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 12,
                sigmaY: 12,
              ),
              child: Container(
                height: deviceSize.height,
                color: Theme.of(context).primaryColor.withOpacity(0.4),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(1.0),
                    Theme.of(context).primaryColor.withOpacity(0.0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [
                    0.3,
                    0.8,
                  ],
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        size: 28,
                        color: Theme.of(context).canvasColor.withOpacity(0.8),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      width: deviceSize.width * 0.6,
                      child: Center(
                        child: AutoSizeText(
                          movieDetails.title,
                          maxLines: 1,
                          minFontSize: 12,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).canvasColor.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        size: 28,
                        color: Colors.transparent,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 250,
                        width: deviceSize.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Hero(
                            transitionOnUserGestures: true,
                            tag: 'poster' + movie.poster,
                            child: Image(
                              image: NetworkImage(
                                imageUrl + movieDetails.backPoster,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Overview',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(context).canvasColor,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    child: Text(
                                      movieDetails.overview,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .canvasColor
                                            .withOpacity(0.75),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[700],
                                  size: 14,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  movieDetails.rating.toString(),
                                  style: TextStyle(
                                    color: Theme.of(context).canvasColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '/10',
                                  style: TextStyle(
                                      color: Theme.of(context).canvasColor,
                                      fontSize: 10),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Container(
                              height: 30,
                              child: ListView.builder(
                                itemCount: movieDetails.genres.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .primaryColorLight
                                          .withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    margin: EdgeInsets.only(right: 5),
                                    child: Center(
                                      child: Text(
                                        movieDetails.genres[index].name,
                                        style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Casts(id: movie.id),
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     margin: EdgeInsets.symmetric(horizontal: 20),
          //     child: MaterialButton(
          //       colorBrightness: Brightness.dark,
          //       color: Theme.of(context).primaryColorDark,
          //       minWidth: deviceSize.width,
          //       padding: EdgeInsets.symmetric(vertical: 20),
          //       child: Text(
          //         'BUY TICKET',
          //         style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           fontSize: 15,
          //         ),
          //       ),
          //       onPressed: () {},
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
