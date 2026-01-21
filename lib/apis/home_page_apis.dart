import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_keys.dart';

Future<dynamic> fetchTrendingMoviesToday(String page) async {
  final response = await http.get(
    Uri.parse('$baseUrl/trending/movie/day?language=en-US&page=$page'),

    headers: {
      'Authorization': 'Bearer $readAccessToken',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    // print('MTData fetched successfully: ${response.body}');
  } else {
    // print('Failed to fetch data: ${response.statusCode}');
  }

  return jsonDecode(response.body);
}

Future<dynamic> fetchTrendingMoviesThisWeek(String page) async {
  final response = await http.get(
    Uri.parse('$baseUrl/trending/movie/week?language=en-US&page=$page'),

    headers: {
      'Authorization': 'Bearer $readAccessToken',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    // print('MWData fetched successfully: ${response.body}');
  } else {
    // print('Failed to fetch data: ${response.statusCode}');
  }

  return jsonDecode(response.body);
}

Future<dynamic> fetchTrendingTvToday(String page) async {
  final response = await http.get(
    Uri.parse('$baseUrl/trending/tv/day?language=en-US&page=$page'),

    headers: {
      'Authorization': 'Bearer $readAccessToken',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    // print('TTData fetched successfully: ${response.body}');
  } else {
    // print('Failed to fetch data: ${response.statusCode}');
  }

  return jsonDecode(response.body);
}

Future<dynamic> fetchTrendingTvThisWeek(String page) async {
  final response = await http.get(
    Uri.parse('$baseUrl/trending/tv/week?language=en-US&page=$page'),

    headers: {
      'Authorization': 'Bearer $readAccessToken',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    // print('TWData fetched successfully: ${response.body}');
  } else {
    // print('Failed to fetch data: ${response.statusCode}');
  }

  return jsonDecode(response.body);
}
