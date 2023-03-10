import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(MoviesState.initial()) {
    getTrendingMovies();
  }

  Future<void> getTrendingMovies() async {
    emit(MoviesState.loading());
    try {
      var dio = Dio();
      final response = await dio.get(
          'https://api.themoviedb.org/3/trending/movie/week?api_key=964085f4fd433d1a9da9fa8dea8e4e4c');
      print(response);
      final movies = response.data['results'];

      emit(MoviesState.sucessfull(response.data['results']));
    } catch (e) {
      print('ERROR');
      // emit(MoviesState.error());
    }
  }
}
