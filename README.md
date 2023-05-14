# TMDB_Flutter
This is a Flutter application that allows users to browse and search for movies using the TMDB movie API.

## Features

- Display popular movies
- Search movies by title
- View movie details

## Dependencies

- `http` package for making API requests
- `flutter_bloc` package for state management
- `cached_network_image` package for loading and caching movie images
- `flutter_rating_bar` package for displaying movie ratings
- `fluttertoast` package for displaying toast messages

## Getting Started

1. Clone the repository:

git clone https://github.com/your-username/your-repository.git

2. Install the dependencies:
flutter pub get

3. Obtain an API key from TMDB:

- Visit the TMDB website: [https://www.themoviedb.org/](https://www.themoviedb.org/)
- Sign up for an account and obtain an API key
- Replace the placeholder API key in the `tmdb_api.dart` file with your actual API key

4. Run the application:
flutter run


## Folder Structure

- `lib/`: Contains the main source code of the application
  - `models/`: Contains the data models used in the application
  - `screens/`: Contains the different screens of the application
  - `services/`: Contains the API service for fetching movie data
  - `utils/`: Contains utility functions and helper classes
  - `widgets/`: Contains reusable UI widgets

## Contributing

Contributions are welcome! If you find any bugs or have suggestions for improvement, please open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).



