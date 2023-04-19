import 'package:flutter/material.dart';
import 'package:movie/helper/api.dart';
import 'package:movie/models/genre_model.dart';
import 'package:movie/models/trending_movie_model.dart';

class MovieDetailsScreen extends StatefulWidget {
  TrendingMovieResult? movies;
  List<Genre>? genres;

  MovieDetailsScreen(this.movies, this.genres);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomLeft,
              children: <Widget>[
                Hero(
                  tag: "${API.imageBasePath}${widget.movies!.id}",
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.57,
                      color: const Color(0xFF333333),
                      child: Image.network(
                          widget.movies!.posterPath == null
                              ? 'https://imgs.search.brave.com/NS0WxMNOu-NGE0HocqQvcdaxA49u1S6AkhF8lSN_Ntk/rs:fit:1200:720:1/g:ce/aHR0cHM6Ly9pLnl0/aW1nLmNvbS92aS9r/WkxRbFVKUmxBNC9t/YXhyZXNkZWZhdWx0/LmpwZw'
                              : "${API.imageBasePath}${widget.movies!.posterPath}",
                          width: double.infinity,
                          fit: BoxFit.cover)),
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.57,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            const Color(0xFF000000).withOpacity(1),
                            Colors.transparent,
                          ],
                          stops: const [
                            0.2,
                            0.4,
                          ]),
                    )),
                Positioned(
                  top: 30,
                  left: 16,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 16),
                      height: 45,
                      width: 45,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white24),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.movies!.title.toString(),
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.07,
                        fontFamily: "Poppins-Bold",
                        color: const Color(0xFFFBFBFB) //Color(0xFF5d59d8)
                        ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          getTextWidgets(context, widget.movies!.genreIds!),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text("Storyline",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w300,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05)),
                          ),
                          Text(widget.movies!.overview.toString(),
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.8),
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w100,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.038))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextWidgets(context, List<int> genresList) {
    List<Widget> list = [];
    for (var i = 0; i < genresList.length; i++) {
      for (int j = 0; j < widget.genres!.length; j++) {
        if (genresList[i] == widget.genres![j].id) {
          list.add(Container(
            decoration: BoxDecoration(
                color: const Color(0xFFee6969),
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 13),
              child: Text(
                widget.genres![j].name.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                    fontSize: MediaQuery.of(context).size.width * 0.033,
                    fontFamily: "Poppins"),
              ),
            ),
          ));
        }
      }
    }

    return Wrap(runSpacing: 8, spacing: 8, children: list);
  }
}
