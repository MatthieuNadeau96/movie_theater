import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_theater/bloc/get_now_playing_movies_bloc.dart';
import 'package:movie_theater/model/movie.dart';
import 'package:movie_theater/model/movie_response.dart';
import 'package:movie_theater/screens/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController carouselController = CarouselController();
  final List<String> header = <String>[
    'In Theater',
    'Upcoming',
    'Recommended',
    'Popular',
    'Top Grossing',
  ];

  int prevMovieIndex = -1;
  int movieIndex = -1;
  bool scrolledYet = false;

  @override
  void initState() {
    super.initState();
    nowPlayingMoviesBloc..getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: nowPlayingMoviesBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildNowPlayingWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
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

  Widget _buildNowPlayingWidget(MovieResponse data) {
    final String imageUrl = 'https://image.tmdb.org/t/p/original/';
    final Size deviceSize = MediaQuery.of(context).size;
    List<Movie> movies = data.movies;
    if (movies.length == 0) {
      return Container(
        child: Center(
          child: Text('No Movies'),
        ),
      );
    } else
      return Scaffold(
        body: Stack(
          children: [
            Container(
              child: CarouselSlider(
                carouselController: carouselController,
                options: CarouselOptions(
                  scrollPhysics: NeverScrollableScrollPhysics(),
                  height: deviceSize.height,
                  viewportFraction: 1,
                ),
                items: movies.sublist(0, 10).map((movie) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
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
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.2),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
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
                      0.1,
                      0.8,
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: deviceSize.height * 0.20,
                  ),
                  Expanded(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            scrolledYet = true;
                            movieIndex = index;
                          });
                          _linkHandler(index);
                          setState(() {
                            prevMovieIndex = index;
                          });
                        },
                        height: 300.0,
                        enlargeCenterPage: true,
                        disableCenter: true,
                        enableInfiniteScroll: true,
                        viewportFraction:
                            (deviceSize.width > 600 && deviceSize.height < 610)
                                ? 0.55
                                : 0.75,
                        aspectRatio: 1,
                      ),
                      items: movies.sublist(0, 10).map((movie) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        print(movie.id);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailScreen(movie: movie),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.47),
                                              spreadRadius: -17,
                                              blurRadius: 15,
                                              offset: Offset(0, 28),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          child: Hero(
                                            tag: 'poster' + movie.poster,
                                            transitionOnUserGestures: true,
                                            child: Image(
                                              image: NetworkImage(
                                                imageUrl + movie.poster,
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: deviceSize.height * 0.20,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            if (!scrolledYet)
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color:
                                Theme.of(context).canvasColor.withOpacity(0.3),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color:
                                Theme.of(context).canvasColor.withOpacity(0.3),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: deviceSize.height * 0.05),
                  ],
                ),
              ),
          ],
        ),
      );
  }

  dynamic _linkHandler(int index) {
    carouselController.jumpToPage(index);
  }
}
