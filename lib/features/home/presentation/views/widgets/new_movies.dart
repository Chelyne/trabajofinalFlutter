import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app/features/home/presentation/views/widgets/card_movie.dart';

import '../cubit_newmovies/movies_cubit.dart';

class NewMovies extends StatelessWidget {
  const NewMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesCubit(),
      child: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'New Movies',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 28,
                      ),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.newMovies.length,
                  itemBuilder: (context, index) {
                    final movie = state.newMovies[index];
                    return CardMovie(
                      movie: state.newMovies[index],
                      title: movie['title'],
                      image: state.newMovies[index]['poster_path'],
                      star: state.newMovies[index]['vote_average'],
                      id: state.newMovies[index]['id'].toString(),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
