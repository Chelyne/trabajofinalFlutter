part of 'upcoming_movies_cubit.dart';

enum UpcomingMoviesStatus {
  initial,
  loading,
  error,
  sucessfull,
}

class UpcomingMoviesState extends Equatable {
  final UpcomingMoviesStatus status;
  final List<dynamic> upcomingMovies;

  UpcomingMoviesState.initial()
      : status = UpcomingMoviesStatus.initial,
        upcomingMovies = [];

  UpcomingMoviesState.loading()
      : status = UpcomingMoviesStatus.loading,
        upcomingMovies = [];

  UpcomingMoviesState.error()
      : status = UpcomingMoviesStatus.error,
        upcomingMovies = [];

  const UpcomingMoviesState.sucessfull(List<dynamic> data)
      : status = UpcomingMoviesStatus.sucessfull,
        upcomingMovies = data;

  @override
  List<Object> get props => [status, upcomingMovies];
}
