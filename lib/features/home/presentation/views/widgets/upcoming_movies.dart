import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/upcoming_movies_cubit.dart';
import 'card_movie.dart';

class UpcomingMovies extends StatelessWidget {
  const UpcomingMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpcomingMoviesCubit(),
      child: BlocBuilder<UpcomingMoviesCubit, UpcomingMoviesState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Upcoming Movies',
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
                height: 190,
                width: MediaQuery.of(context).size.width.round() * 0.95,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.upcomingMovies.length,
                  itemBuilder: (context, index) {
                    return CardMovie(
                      movie: state.upcomingMovies[index],
                      image: state.upcomingMovies[index]['poster_path'],
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
