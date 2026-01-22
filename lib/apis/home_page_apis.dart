import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../api_keys.dart';

// Future<dynamic> fetchTrendingMoviesToday(String page) async {
//   final response = await http.get(
//     Uri.parse('$baseUrl/trending/movie/day?language=en-US&page=$page'),

//     headers: {
//       'Authorization': 'Bearer $readAccessToken',
//       'Accept': 'application/json',
//     },
//   );

//   if (response.statusCode == 200) {
//     // print('MTData fetched successfully: ${response.body}');
//   } else {
//     print('Failed to fetch data: ${response.statusCode}');
//   }

//   return jsonDecode(response.body);
// }

// Future<dynamic> fetchTrendingMoviesThisWeek(String page) async {
//   final response = await http.get(
//     Uri.parse('$baseUrl/trending/movie/week?language=en-US&page=$page'),

//     headers: {
//       'Authorization': 'Bearer $readAccessToken',
//       'Accept': 'application/json',
//     },
//   ).timeout(const Duration(seconds: 10));

//   if (response.statusCode == 200) {
//     return jsonDecode(response.body);
//     // print('MWData fetched successfully: ${response.body}');
//   } else {
//     print('Failed to fetch data: ${response.statusCode}');
//   }

//   return jsonDecode(response.body);
// }

// Future<dynamic> fetchTrendingTvToday(String page) async {
//   final response = await http.get(
//     Uri.parse('$baseUrl/trending/tv/day?language=en-US&page=$page'),

//     headers: {
//       'Authorization': 'Bearer $readAccessToken',
//       'Accept': 'application/json',
//     },
//   );

//   if (response.statusCode == 200) {
//     // print('TTData fetched successfully: ${response.body}');
//   } else {
//     print('Failed to fetch data: ${response.statusCode}');
//   }

//   return jsonDecode(response.body);
// }

// Future<dynamic> fetchTrendingTvThisWeek(String page) async {
//   final response = await http.get(
//     Uri.parse('$baseUrl/trending/tv/week?language=en-US&page=$page'),

//     headers: {
//       'Authorization': 'Bearer $readAccessToken',
//       'Accept': 'application/json',
//     },
//   );

//   if (response.statusCode == 200) {
//     // print('TWData fetched successfully: ${response.body}');
//   } else {
//     print('Failed to fetch data: ${response.statusCode}');
//   }

//   return jsonDecode(response.body);
// }
final http.Client _client = http.Client();

Map<String, String> get _headers => {
  'Authorization': 'Bearer $readAccessToken',
  'Accept': 'application/json',
};

Future<Map<String, dynamic>> _safeGet(String url) async {
  try {
    final response = await _client
        .get(Uri.parse(url), headers: _headers)
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }

    throw HttpException(
      'Request failed: ${response.statusCode}',
      uri: Uri.parse(url),
    );
  } on TimeoutException {
    throw Exception('Request timeout');
  } on SocketException {
    throw Exception('Network error (connection reset)');
  } catch (e) {
    rethrow;
  }
}

Future<Map<String, dynamic>> fetchTrendingMoviesToday(String page) {
  return _safeGet('$baseUrl/trending/movie/day?language=en-US&page=$page');
}

Future<Map<String, dynamic>> fetchTrendingMoviesThisWeek(String page) {
  return _safeGet('$baseUrl/trending/movie/week?language=en-US&page=$page');
}

Future<Map<String, dynamic>> fetchTrendingTvToday(String page) {
  return _safeGet('$baseUrl/trending/tv/day?language=en-US&page=$page');
}

Future<Map<String, dynamic>> fetchTrendingTvThisWeek(String page) {
  return _safeGet('$baseUrl/trending/tv/week?language=en-US&page=$page');
}
