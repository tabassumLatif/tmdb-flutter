import 'package:http/http.dart' as http;
import 'dart:convert';

class TMDBAPI {
  static const String _apiKey = '83d01f18538cb7a275147492f84c3698';
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  static Future<List<dynamic>> fetchMovies() async {
    final url = Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['results'];
    } else {
      throw Exception('Failed to fetch movies');
    }
  }


  static Future<Map<String, dynamic>> fetchMovieDetails(int movieId) async {
    final url = Uri.parse('$_baseUrl/movie/$movieId?api_key=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to fetch movie details');
    }
  }


  static Future<List<dynamic>> searchMovies(String query) async {
    final encodedQuery = Uri.encodeQueryComponent(query);
    final url = Uri.parse('$_baseUrl/search/movie?api_key=$_apiKey&query=$encodedQuery');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['results'];
    } else {
      throw Exception('Failed to search movies');
    }
  }

// Implement other API requests as needed
}
