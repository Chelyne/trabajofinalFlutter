part of 'movies_cubit.dart';

enum MoviesStatus {
  initial,
  loading,
  error,
  sucessfull,
}

class MoviesState extends Equatable {
  final MoviesStatus status;
  final List<dynamic> upcomingMovies;
  final List<dynamic> title;

  MoviesState.initial()
      : status = MoviesStatus.initial,
        upcomingMovies = [],
        title = [];

  MoviesState.loading()
      : status = MoviesStatus.loading,
        upcomingMovies = [],
        title = [];

  MoviesState.error()
      : status = MoviesStatus.error,
        upcomingMovies = [],
        title = [];

  const MoviesState.sucessfull(List<dynamic> data)
      : status = MoviesStatus.sucessfull,
        title = data,
        upcomingMovies = data;

  @override
  List<Object> get props => [status, upcomingMovies, title];
}
