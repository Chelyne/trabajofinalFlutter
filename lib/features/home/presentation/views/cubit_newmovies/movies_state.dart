part of 'movies_cubit.dart';

enum MoviesStatus {
  initial,
  loading,
  error,
  sucessfull,
}

class MoviesState extends Equatable {
  final MoviesStatus status;
  final List<dynamic> title;
  final List<dynamic> newMovies;

  MoviesState.initial()
      : status = MoviesStatus.initial,
        newMovies = [],
        title = [];

  MoviesState.loading()
      : status = MoviesStatus.loading,
        newMovies = [],
        title = [];

  MoviesState.error()
      : status = MoviesStatus.error,
        newMovies = [],
        title = [];

  const MoviesState.sucessfull(List<dynamic> data)
      : status = MoviesStatus.sucessfull,
        title = data,
        newMovies = data;

  @override
  List<Object> get props => [status, title, newMovies];
}
