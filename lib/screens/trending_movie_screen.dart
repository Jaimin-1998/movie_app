import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie/controllers/trending_movie_controller.dart';
import 'package:movie/helper/api.dart';
import 'package:movie/screens/movie_details_screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class TrendingMovieClass extends StatefulWidget {
  const TrendingMovieClass({Key? key}) : super(key: key);

  @override
  TrendingMovieClassState createState() => TrendingMovieClassState();
}

class TrendingMovieClassState extends StateMVC<TrendingMovieClass> {
  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();
  TrendingMovieController? _con;
  ScrollController scrollController = ScrollController();

  TrendingMovieClassState() : super(TrendingMovieController()) {
    _con = controller as TrendingMovieController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con!.resultsMultipleData!.clear();
    _con!.getTrendingMovieAPI(page: 1);
    _con!.getGenreAPI();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text('Movie',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins')),
      ),
      body: _con!.resultsMultipleData.toString() == '[]' ||
              _con!.resultsMultipleData!.isEmpty
          ? Container()
          : Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView.separated(
                      controller: scrollController
                        ..addListener(() {
                          if (scrollController.position.pixels ==
                              scrollController.position.maxScrollExtent) {
                            if (_con!.currentPage != _con!.totalPages) {
                              if (searchController.text.isNotEmpty) {
                                _con!.getSearchAPI(
                                  searchController.text,
                                  page: _con!.currentPage! + 1,
                                );
                              } else {
                                _con!.getTrendingMovieAPI(
                                    page: _con!.currentPage! + 1);
                              }
                            }
                          }
                        }),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const Divider(
                            color: Colors.transparent,
                          ),
                      itemCount: _con!.resultsMultipleData!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.all(4.0),
                          height: height * 0.19,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Positioned(
                                child: Container(
                                  height: height * 0.162,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Color(0xFF1a1c20),
                                            Color(0xFF222222),
                                          ]),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: height * 0.162 + 16,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 16),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                _con!
                                                    .resultsMultipleData![index]
                                                    .title
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w300,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04),
                                              ),
                                              getTextWidgets(
                                                  context,
                                                  _con!
                                                      .resultsMultipleData![
                                                          index]
                                                      .genreIds!),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    "⭐ ${_con!.resultsMultipleData![index].voteAverage}",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: "Poppins",
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.033),
                                                  ),
                                                  SizedBox(
                                                    child: Text(
                                                      "  |  ",
                                                      style: TextStyle(
                                                          color: Colors.white24,
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          fontFamily:
                                                              "Poppins-Light",
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.03),
                                                    ),
                                                  ),
                                                  Text(
                                                    " ${_con!.resultsMultipleData![index].releaseDate.toString().split(' ').first}",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w100,
                                                        fontFamily: "Poppins",
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.033),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 16,
                                top: 0,
                                height: height * 0.19,
                                width: height * 0.16,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                MovieDetailsScreen(
                                                    _con!.resultsMultipleData![
                                                        index],
                                                    _con!.genres)));
                                  },
                                  child: Hero(
                                    tag:
                                        "${API.imageBasePath}${_con!.resultsMultipleData![index].id}",
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF333333),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                              _con!.resultsMultipleData![index]
                                                          .posterPath ==
                                                      null
                                                  ? 'https://imgs.search.brave.com/vGalJDtfESWK5vZBnp4nceh8XoqhVKBHY2PaQHPKaxk/rs:fit:1200:1200:1/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzL2RjL2M4/LzA2L2RjYzgwNjU3/ODUzYWIxZWVjNDVh/M2Y0NTg3MmIwMmM5/LmpwZw'
                                                  : "${API.imageBasePath}${_con!.resultsMultipleData![index].posterPath}",
                                              width: 145,
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
    );
  }

  Widget getTextWidgets(context, List<int> genersList) {
    List<Widget> list = [];
    for (var i = 0; i < genersList.length; i++) {
      for (var j = 0; j < _con!.genres!.length; j++) {
        if (genersList[i] == _con!.genres![j].id) {
          list.add(Text(
            _con!.genres![j].name.toString(),
            style: TextStyle(
                color: Colors.white60,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.width * 0.033),
          ));
        }
      }
    }
    return Wrap(runSpacing: 2, spacing: 4, children: list);
  }

  Widget searchBox() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF222222),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: TextFormField(
            controller: searchController,
            focusNode: focusNode,
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (value) {
              if (searchController.text.isNotEmpty) {
                _con!.resultsMultipleData!.clear();
                setState(() {
                  _con!.getSearchAPI(
                    searchController.text,
                    page: 1,
                  );
                });
              }
            },
            cursorColor: const Color(0xFFdddddd),
            style: const TextStyle(
                fontSize: 18,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w300,
                color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search.. ",
              hintStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.white54,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w300),
              suffixIcon: searchController.text.isEmpty
                  ? const SizedBox(height: 0, width: 0)
                  : InkWell(
                      child: const Icon(
                        Icons.close,
                        size: 23,
                        color: Color(0xFF888888),
                      ),
                      onTap: () {
                        setState(() {
                          searchController.clear();
                          _con!.getTrendingMovieAPI(page: 1);
                        });
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
