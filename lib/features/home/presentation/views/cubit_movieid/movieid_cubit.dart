import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'movieid_state.dart';

class MovieIdCubit extends Cubit<MovieIdState> {
  MovieIdCubit() : super(MovieIdState.initial()) {
    // getTrendingMovies(id);
  }

  Future<void> getTrendingMovies(String id) async {
    print(id);
    emit(MovieIdState.loading());
    try {
      var dio = Dio();
      final response = await dio.get(
          'https://api.themoviedb.org/3/movie/$id?api_key=964085f4fd433d1a9da9fa8dea8e4e4c');
      final videoResponse = await dio.get(
          'https://api.themoviedb.org/3/movie/$id/videos?api_key=964085f4fd433d1a9da9fa8dea8e4e4c');
      final data = response.data;
      final videoData = videoResponse.data;
      final videoResult = videoData['results'][0];

      final url = 'https://www.youtube.com/watch?v=${videoResult['key']}';

      emit(MovieIdState.sucessfull(data, url));
    } catch (e) {
      print('ERRORRR');
      // emit(MoviesState.error());
    }
  }
}
