import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_theater/bloc/get_now_playing_movies_bloc.dart';
import 'package:movie_theater/model/movie.dart';
import 'package:movie_theater/model/movie_response.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> header = <String>[
    'In Theater',
    'Upcoming',
    'Recommended',
    'Popular',
  ];

  @override
  void initState() {
    // TODO: implement initState
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

  Widget _buildNowPlayingWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    if (movies.length == 0) {
      return Container(
        child: Center(
          child: Text('No Movies'),
        ),
      );
    } else
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          leading: IconButton(
            icon: Icon(
              Icons.menu_rounded,
            ),
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            )
          ],
          elevation: 0,
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                height: 90,
                // flex: 1,
                child: Container(
                  // height: 100,
                  color: Colors.grey[200],
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: header.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.only(right: 20, left: 18),
                        child: Text(
                          header[index],
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                height: 400,
                // flex: 6,
                child: CarouselSlider(
                  options: CarouselOptions(
                    // height: 300.0,
                    enlargeCenterPage: true,
                    disableCenter: true,
                    enableInfiniteScroll: true,
                  ),
                  items: movies.map((movie) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          'https://image.tmdb.org/t/p/original/' +
                                              movie.poster,
                                        ),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  movie.title,
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow[800],
                                    ),
                                    Text(movie.rating.toString()),
                                  ],
                                ),
                              )
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
      );
  }
}
