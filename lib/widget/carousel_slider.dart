import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/model/model_movie.dart';
import 'package:netflixclone/screen/detail_screen.dart';

class CarouselImage extends StatefulWidget {
  final List<Movie> movies;
  const CarouselImage({super.key, required this.movies});

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  late List<Movie> movies;
  late List<Widget> images;
  late List<String> keywords;
  late List<bool> likes;
  int _currentPage = 0;
  late String _currentKeyword;

  @override
  void initState() {
    super.initState();
    movies = widget.movies;
    images = movies
        .map((m) => Image.asset(
              './images/${m.poster}',
              fit: BoxFit.fitWidth,
            ))
        .toList();
    keywords = movies.map((m) => m.keyword).toList();
    likes = movies.map((m) => m.like).toList();
    _currentKeyword = keywords[_currentPage];
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
          CarouselSlider(
            items: images
                .map((image) => Stack(
                      children: [
                        SizedBox(
                          width: deviceWidth,
                          child: image,
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: deviceWidth,
                            height: deviceHeight / 4,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 49, 49, 49),
                                  Color.fromARGB(170, 51, 51, 51),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        )
                      ],
                    ))
                .toList(),
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                  _currentKeyword = keywords[_currentPage];
                });
              },
              height: deviceHeight / 2,
              viewportFraction: 1,
              enableInfiniteScroll: false,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(
              0,
              10,
              0,
              3,
            ),
            child: Text(
              _currentKeyword,
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                    children: [
                      likes[_currentPage]
                          ? IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.check),
                            )
                          : IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.add),
                            ),
                      const Text(
                        '내가 찜한 콘텐츠',
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.white,
                  child: GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.play_arrow,
                              color: Colors.black,
                            ),
                            Padding(
                              padding: EdgeInsets.all(3),
                            ),
                            Text(
                              '재생',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) {
                                return DetailScreen(
                                    movie: movies[_currentPage]);
                              },
                            ));
                          },
                          icon: const Icon(Icons.info)),
                      const Text(
                        '정보',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: makeIndicator(likes, _currentPage),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> makeIndicator(List list, int currentPage) {
  List<Widget> results = [];
  final indicators = list.asMap().keys.toList();
  for (var i in indicators) {
    results.add(Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 2,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentPage == i
            ? const Color.fromRGBO(255, 255, 255, .9)
            : const Color.fromRGBO(255, 255, 255, .4),
      ),
    ));
  }

  return results;
}
