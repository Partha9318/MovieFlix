import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_keys.dart';

Future<dynamic> searchMoviesAndTvShows(String query, int page) async {
  final response = await http.get(
    Uri.parse('$baseUrl/search/movie?query=$query&page=$page'),

    headers: {
      'Authorization': 'Bearer $readAccessToken',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    // print('SearchData fetched successfully: ${response.body}');
  } else {
    // print('Failed to fetch data: ${response.statusCode}');
  }

  return jsonDecode(response.body);
}

Future<dynamic> loadMoreSearchResults(String query, int page) async {
  final response = await http.get(
    Uri.parse('$baseUrl/search/movie?query=$query&page=$page'),

    headers: {
      'Authorization': 'Bearer $readAccessToken',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    // print('LoadMoreSearchData fetched successfully: ${response.body}');
  } else {
    // print('Failed to fetch data: ${response.statusCode}');
  }

  return jsonDecode(response.body);
}
