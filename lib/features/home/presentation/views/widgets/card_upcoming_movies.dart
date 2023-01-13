import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/upcoming_movies_cubit.dart';

class UpcomingCard extends StatelessWidget {
  const UpcomingCard({
    Key? key,
    required Map<String, dynamic> this.movie,
    final String? this.image,
  }) : super(key: key);
  final Map<String, dynamic> movie;
  final String? image;
  @override
  Widget build(BuildContext context) {
    final String title = movie['title'];
    return BlocProvider(
      create: (context) => UpcomingMoviesCubit(),
      child: BlocBuilder<UpcomingMoviesCubit, UpcomingMoviesState>(
        builder: (context, state) {
          return InkWell(
            onTap: () {
              print('Movie 1');
            },
            child: Container(
              width: 190,
              height: 400,
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF292B37),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF292B37).withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500$image',
                      height: 250,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
