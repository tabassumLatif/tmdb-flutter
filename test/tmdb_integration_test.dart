import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb_flutter/ui/popular_movies.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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

  testWidgets('Search movies - Valid query', (WidgetTester tester) async {
    await tester.pumpWidget(PopularMovies(key: Key("PopularMovies"),));

    // Enter a search query
    final query = 'Avengers';
    final searchField = find.byType(TextField);
    await tester.enterText(searchField, query);

    // Tap the search icon
    final searchIcon = find.byIcon(Icons.search);
    await tester.tap(searchIcon);
    await tester.pumpAndSettle();

    // Verify the movie list contains search results
    final movieList = find.byType(ListView);
    expect(movieList, findsOneWidget);

    final movieTiles = find.byType(ListTile);
    expect(movieTiles, findsNWidgets(2)); // Adjust the expected number based on the search results
  });

  testWidgets('Search movies - Empty query', (WidgetTester tester) async {
    await tester.pumpWidget(const PopularMovies(key: Key("PopularMovies"),));

    // Leave the search query empty
    final searchField = find.byType(TextField);
    await tester.enterText(searchField, '');

    // Tap the search icon
    final searchIcon = find.byIcon(Icons.search);
    await tester.tap(searchIcon);
    await tester.pumpAndSettle();

    // Verify the movie list contains popular movies
    final movieList = find.byType(ListView);
    expect(movieList, findsOneWidget);

    final movieTiles = find.byType(ListTile);
    expect(movieTiles, findsNWidgets(5)); // Adjust the expected number based on the popular movies count
  });

  // Add more integration tests for other API requests
}
