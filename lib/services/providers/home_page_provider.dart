import 'package:flutter/material.dart';
import 'package:movieflix/apis/home_page_apis.dart';

class HomePageProvider extends ChangeNotifier {
  List trendingMoviesToday = [];
  List trendingMoviesThisWeek = [];
  List trendingTvToday = [];
  List trendingTvThisWeek = [];
  bool isLoading = true;
  int trendingMoviesTodayPage = 1;
  int trendingMoviesThisWeekPage = 1;
  int trendingTvTodayPage = 1;
  int trendingTvThisWeekPage = 1;

  void fetchAllData() async {
    try {
      // final results = await Future.wait([
      //   fetchTrendingMoviesToday("1"),
      //   fetchTrendingMoviesThisWeek("1"),
      //   fetchTrendingTvToday("1"),
      //   fetchTrendingTvThisWeek("1"),
      // ]);
      final moviesToday = await fetchTrendingMoviesToday("1");
      final moviesWeek = await fetchTrendingMoviesThisWeek("1");
      final tvToday = await fetchTrendingTvToday("1");
      final tvWeek = await fetchTrendingTvThisWeek("1");

      trendingMoviesToday = moviesToday['results'];
      trendingMoviesThisWeek = moviesWeek['results'];
      trendingTvToday = tvToday['results'];
      trendingTvThisWeek = tvWeek['results'];
      isLoading = false;

      notifyListeners();
    } catch (e) {
      print('Error fetching data: $e');

      isLoading = false;
      notifyListeners();
    }
  }

  void fetchMoreTrendingMoviesToday() async {
    trendingMoviesTodayPage++;
    try {
      final result = await fetchTrendingMoviesToday(
        trendingMoviesTodayPage.toString(),
      );
      trendingMoviesToday.addAll(result['results']);

      notifyListeners();
    } catch (e) {
      print('Error fetching more trending movies today: $e');
    }
  }

  void fetchMoreTrendingMoviesThisWeek() async {
    trendingMoviesThisWeekPage++;
    try {
      final result = await fetchTrendingMoviesThisWeek(
        trendingMoviesThisWeekPage.toString(),
      );
      trendingMoviesThisWeek.addAll(result['results']);
      notifyListeners();
    } catch (e) {
      print('Error fetching more trending movies this week: $e');
    }
  }

  void fetchMoreTrendingTvToday() async {
    trendingTvTodayPage++;
    try {
      final result = await fetchTrendingTvToday(trendingTvTodayPage.toString());
      trendingTvToday.addAll(result['results']);
      notifyListeners();
    } catch (e) {
      print('Error fetching more trending TV today: $e');
    }
  }

  void fetchMoreTrendingTvThisWeek() async {
    trendingTvThisWeekPage++;
    try {
      final result = await fetchTrendingTvThisWeek(
        trendingTvThisWeekPage.toString(),
      );
      trendingTvThisWeek.addAll(result['results']);
      notifyListeners();
    } catch (e) {
      print('Error fetching more trending TV this week: $e');
    }
  }
}
