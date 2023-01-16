part of 'movieid_cubit.dart';

enum MovieIdStatus {
  initial,
  loading,
  error,
  sucessfull,
}

class MovieIdState extends Equatable {
  final MovieIdStatus status;
  final Map<String, dynamic> movie;
  final String url;
  MovieIdState.initial()
      : status = MovieIdStatus.initial,
        movie = {},
        url = 'https://flutter.dev';

  MovieIdState.loading()
      : status = MovieIdStatus.loading,
        url = 'https://flutter.dev',
        movie = {};

  MovieIdState.error()
      : status = MovieIdStatus.error,
        url = 'https://flutter.dev',
        movie = {};

  MovieIdState.sucessfull(Map<String, dynamic> data, String urlData)
      : status = MovieIdStatus.sucessfull,
        url = urlData,
        movie = data;

  @override
  List<Object> get props => [status, movie, url];
}
