import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit_newmovies/movies_cubit.dart';

class CardMovie extends StatelessWidget {
  CardMovie({
    Key? key,
    required Map<String, dynamic> this.movie,
    final String? this.title,
    final String? this.image,
    final double? this.star,
    final String? this.id,
  }) : super(key: key);
  final Map<String, dynamic> movie;
  final String? title;
  final String? image;
  final double? star;

  final String? id;

  @override
  Widget build(BuildContext context) {
    final String title = movie['title'];
    return BlocProvider(
      create: (context) => MoviesCubit(),
      child: BlocBuilder<MoviesCubit, MoviesState>(
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
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${title}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 21,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Action/Adventure',
                          style: TextStyle(
                            color: Colors.white54,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '$star',
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )
                      ],
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
