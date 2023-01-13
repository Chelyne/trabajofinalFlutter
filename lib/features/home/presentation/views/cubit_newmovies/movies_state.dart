part of 'movies_cubit.dart';

enum MoviesStatus {
  initial,
  loading,
  error,
  sucessfull,
}

class MoviesState extends Equatable {
  final MoviesStatus status;
  final List<dynamic> newMovies;

  MoviesState.initial()
      : status = MoviesStatus.initial,
        newMovies = [];

  MoviesState.loading()
      : status = MoviesStatus.loading,
        newMovies = [];

  MoviesState.error()
      : status = MoviesStatus.error,
        newMovies = [];

  const MoviesState.sucessfull(List<dynamic> data)
      : status = MoviesStatus.sucessfull,
        newMovies = data;

  @override
  List<Object> get props => [status, newMovies];
}
