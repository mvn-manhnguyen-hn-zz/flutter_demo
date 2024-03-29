import 'package:flutter_review_movie/core/core.dart';

class MovieResponse {
  final int pageIndex;
  final int totalResults;
  final int totalPages;
  final List<Movie> movies;

  MovieResponse.fromJSON(Map<String, dynamic> json)
      : pageIndex = json['page'],
        totalResults = json['total_results'],
        totalPages = json['total_pages'],
        movies = (json['results'] as List)
            .map((json) => Movie.fromJSON(json))
            .toList();

  static errorValue(String error) => print(error);
}

class Movie extends MovieEntity{
  final int id;
  final voteAverage;
  final String title;
  final String posterPath;
  final String overview;
  final String backdropPath;
  final String releaseDate;
  final int voteCount;

  Movie(this.backdropPath, this.voteCount, this.releaseDate,
      {this.id, this.voteAverage, this.title, this.posterPath, this.overview}) : super('', 0, '');

  Movie.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        voteAverage = json['vote_average'],
        title = json['title'],
        posterPath = json['poster_path'],
        overview = json['overview'],
        backdropPath = json['backdrop_path'],
        voteCount = json['vote_count'],
        releaseDate = json['release_date'], super('', 0, '');
}
