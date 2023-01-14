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

  MovieIdState.initial()
      : status = MovieIdStatus.initial,
        movie = {};

  MovieIdState.loading()
      : status = MovieIdStatus.loading,
        movie = {};

  MovieIdState.error()
      : status = MovieIdStatus.error,
        movie = {};

  MovieIdState.sucessfull(Map<String, dynamic> data)
      : status = MovieIdStatus.sucessfull,
        movie = data;

  @override
  List<Object> get props => [status, movie];
}
