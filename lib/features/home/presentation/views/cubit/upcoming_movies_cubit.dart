import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'upcoming_movies_state.dart';

class UpcomingMoviesCubit extends Cubit<UpcomingMoviesState> {
  UpcomingMoviesCubit() : super(UpcomingMoviesState.initial()) {
    getTrendingMovies();
  }

  Future<void> getTrendingMovies() async {
    try {
      emit(UpcomingMoviesState.loading());

      var dio = Dio();
      final response = await dio.get(
          'https://api.themoviedb.org/3/movie/upcoming?api_key=964085f4fd433d1a9da9fa8dea8e4e4c');
      print(response);
      final movies = response.data['results'];

      emit(UpcomingMoviesState.sucessfull(response.data['results']));
    } catch (e) {
      print('ERROR');
      // emit(MoviesState.error());
    }
  }
}
