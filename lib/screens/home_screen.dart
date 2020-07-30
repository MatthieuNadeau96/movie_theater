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
  final List<String> header = <String>[
    'In Theater',
    'Upcoming',
    'Recommended',
    'Popular',
    'Top Grossing',
  ];

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
                height: 100,
                // flex: 1,
                child: Container(
                  height: 120,
                  // color: Colors.grey[200],
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: header.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 20, left: 18),
                            child: Text(
                              header[index],
                              style: TextStyle(
                                  fontSize: 30,
                                  color: index == 0
                                      ? Colors.black
                                      : Colors.grey[400]),
                            ),
                          ),
                          if (index == 0)
                            Align(
                              heightFactor: 10.5,
                              widthFactor: 1.4,
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: 50,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                // height: 400,
                flex: 6,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 300.0,
                    enlargeCenterPage: true,
                    disableCenter: true,
                    enableInfiniteScroll: true,
                    viewportFraction: deviceSize.width > 600 ? 0.55 : 0.75,
                    aspectRatio: 1,
                  ),
                  items: movies.map((movie) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          child: Column(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailScreen(movie: movie),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image(
                                        image: NetworkImage(
                                          'https://image.tmdb.org/t/p/original/' +
                                              movie.poster,
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                child: Text(
                                  movie.title,
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow[800],
                                      size: 12,
                                    ),
                                    Text(movie.rating.toString()),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.10,
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
      );
  }
}
