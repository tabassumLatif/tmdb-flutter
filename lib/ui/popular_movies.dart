import 'package:flutter/material.dart';

import '../api/tmdb_api.dart';


class PopularMovies extends StatefulWidget {
  const PopularMovies({required Key key}) : super(key: key);
  @override
  _PopularMoviesState createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  List<dynamic> _movies = [];
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPopularMovies();
  }

  Future<void> fetchPopularMovies() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final movies = await TMDBAPI.fetchMovies();
      setState(() {
        _movies = movies;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('Failed to fetch movies: $error');
    }
  }

  Future<void> searchMovies(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final movies = await TMDBAPI.searchMovies(query);
      setState(() {
        _movies = movies;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('Failed to search movies: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search movies',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final query = _searchController.text;
                    searchMovies(query);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.7,
              ),
              itemCount: _movies.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = _movies[index];
                final movieTitle = movie['title'];

                return GestureDetector(
                  onTap: () {
                    // Handle movie tap here
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w200/${movie['poster_path']}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Wrap(
                        children: [Text(
                          movieTitle,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        )],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/*

class PopularMovies extends StatefulWidget {
  const PopularMovies({required Key key}) : super(key: key);

  @override
  State<PopularMovies> createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: TMDBAPI.fetchMovies(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Failed to load movies');
          } else {
            final movies = snapshot.data;
            // Display the movie data using Flutter widgets
            // For example, create a ListView of movie posters
            return ListView.builder(
              itemCount: movies?.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = movies?[index];
                return ListTile(
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w200/${movie['poster_path']}',
                  ),
                  title: Text(movie['title']),
                  // Implement the logic for displaying movie details when tapped
                );
              },
            );
          }
        },
      )
    );
  }

}
*/
