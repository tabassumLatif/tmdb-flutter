import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  testWidgets('Fetch movies from TMDB API', (WidgetTester tester) async {
    const apiKey = '83d01f18538cb7a275147492f84c3698';
    final url = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=$apiKey');

    final response = await http.get(url);

    expect(response.statusCode, equals(200));

    final jsonData = json.decode(response.body);
    final results = jsonData['results'];

    expect(results, isList);
    expect(results.length, greaterThan(0));
  });

  testWidgets('Fetch movie details from TMDB API', (WidgetTester tester) async {
    final apiKey = '83d01f18538cb7a275147492f84c3698';
    final movieId = 724495; // Replace with a valid movie ID
    final url = Uri.parse('https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey');

    final response = await http.get(url);

    expect(response.statusCode, equals(200));

    final jsonData = json.decode(response.body);
    expect(jsonData, isNotNull);
    expect(jsonData['id'], equals(movieId));
  });

  // Add more integration tests for other API requests
}
