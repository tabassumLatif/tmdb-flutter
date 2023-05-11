// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tmdb_flutter/api/tmdb_api.dart';

import 'package:tmdb_flutter/main.dart';
import 'package:tmdb_flutter/ui/popular_movies.dart';

void main() {
  //Test case: Verify that the movie list is fetched successfully from the TMDB API.
  test('Fetch movies', () async {
    final movies = await TMDBAPI.fetchMovies();
    expect(movies, isList);
    expect(movies.length, greaterThan(0));
  });


  //Test case: Check that the movie details are retrieved correctly for a specific movie.
  test('Fetch movie details', () async {
    const movieId = 724495; // Replace with a valid movie ID
    final movieDetails = await TMDBAPI.fetchMovieDetails(movieId);
    expect(movieDetails, isNotNull);
    expect(movieDetails['id'], equals(movieId));
  });

  //Test case: Ensure that the movie search functionality returns valid search results.
  test('Search movies', () async {
    const query = 'action'; // Replace with a valid search query
    final searchResults = await TMDBAPI.searchMovies(query);
    expect(searchResults, isList);
    expect(searchResults.length, greaterThan(0));
    // Implement additional assertions based on your search functionality
  });

  //Test case: Validate that the movie posters are displayed correctly in the user interface
  testWidgets('Display movie posters', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PopularMovies(key: Key("PopularMovies"),),
      ),
    );

    final moviePostersFinder = find.byType(Image);
    expect(moviePostersFinder, findsWidgets);
  });

  //Test case: Test the functionality of tapping on a movie to display its details.
  testWidgets('Display movie details', (WidgetTester tester) async {
    const movieId = 724495; // Replace with a valid movie ID

    await tester.pumpWidget(
      MaterialApp(
        home: PopularMovies(key: Key("PopularMovies"),),
      ),
    );

    // Tap on a movie
    await tester.tap(find.byKey(Key('movie_$movieId')));
    await tester.pumpAndSettle();

    // Verify that the movie details screen is displayed
    final movieTitleFinder = find.text('Movie Title');
    expect(movieTitleFinder, findsOneWidget);
    // Implement additional assertions based on your movie details screen
  });

}
