import 'package:flutter/material.dart';
import 'package:movieflix/colors.dart';
import 'package:movieflix/components/horizontal_list_viewer.dart';
import 'package:movieflix/services/providers/home_page_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<HomePageProvider>().fetchAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, homePageProvider, child) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: Text(
              'MovieFlix',
              style: TextStyle(
                fontSize: 30,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),

            backgroundColor: Colors.transparent,
          ),
          body: homePageProvider.isLoading == true
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      HorizontalListViewer(
                        list: homePageProvider.trendingMoviesToday,
                        title: "Movies Trending Today",
                        onEndReached:
                            homePageProvider.fetchMoreTrendingMoviesToday,
                      ),
                      HorizontalListViewer(
                        list: homePageProvider.trendingTvToday,
                        title: "TV Shows Trending Today",
                        onEndReached: homePageProvider.fetchMoreTrendingTvToday,
                      ),
                      HorizontalListViewer(
                        list: homePageProvider.trendingMoviesThisWeek,
                        title: "Movies Trending This Week",
                        onEndReached:
                            homePageProvider.fetchMoreTrendingMoviesThisWeek,
                      ),
                      HorizontalListViewer(
                        list: homePageProvider.trendingTvThisWeek,
                        title: "TV Shows Trending This Week",
                        onEndReached:
                            homePageProvider.fetchMoreTrendingTvThisWeek,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
