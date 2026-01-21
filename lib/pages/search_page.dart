import 'package:flutter/material.dart';
import 'package:movieflix/apis/search_page_apis.dart';
import 'package:movieflix/colors.dart';
import 'package:movieflix/components/movie_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FocusScopeNode _focusNode = FocusScopeNode();
  final ScrollController _searchPageScrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  int currentPage = 1;
  List searchResults = [];
  late int totalPages;
  @override
  void initState() {
    _searchPageScrollController.addListener(() async {
      if (_searchPageScrollController.position.maxScrollExtent ==
          _searchPageScrollController.offset) {
        currentPage++;
        var results = await loadMoreSearchResults(
          _searchController.text,
          currentPage,
        );

        setState(() {
          searchResults.addAll(results['results']);
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchPageScrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Search movies or TV shows',
            style: TextStyle(
              fontSize: 24,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                focusNode: _focusNode,
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: subTextColor),
                  filled: true,
                  fillColor: tileColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search, color: subTextColor),
                ),
                onChanged: (query) async {
                  _searchPageScrollController.animateTo(
                    0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                  var results = await searchMoviesAndTvShows(query, 1);
                  setState(() {
                    searchResults = results['results'];
                    totalPages = results['total_pages'];
                  });
                },
              ),
            ),
            SizedBox(
              height: 600,
              child: GridView.builder(
                shrinkWrap: true,
                controller: _searchPageScrollController,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.65,
                ),
                itemCount: searchResults.length + 1,
                itemBuilder: (context, index) {
                  if (index < searchResults.length) {
                    final movie = searchResults[index];
                    return MovieTile(movie: movie);
                  } else {
                    if (_searchController.text.isEmpty) {
                      return null;
                    } else {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: totalPages < currentPage
                            ? Text(
                                'No more results',
                                style: TextStyle(color: subTextColor),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                  color: subTextColor,
                                ),
                              ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
