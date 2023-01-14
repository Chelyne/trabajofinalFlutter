import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app/features/home/presentation/views/cubit_movieid/movieid_cubit.dart';
import 'package:flutter_movie_app/features/home/presentation/views/widgets/buttons.dart';
import 'package:flutter_movie_app/widgets/movies_nav_bar.dart';

import '../../../../widgets/details_header.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;

    return BlocProvider(
      create: (context) => MovieIdCubit()..getTrendingMovies(id),
      child: BlocBuilder<MovieIdCubit, MovieIdState>(
        builder: (context, state) {
          if (state.status == MovieIdStatus.loading) return SizedBox.shrink();
          // final poster = state.movie != {} ? state.movie['poster_path'] : '';
          final backdrop = state.movie['backdrop_path'];
          final poster = state.movie['poster_path'];
          final title = state.movie['original_title'];
          final resume = state.movie['overview'];
          print(state.movie);
          // print(poster);
          // print(backdrop);

          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  DetailsHeader(
                    backdrop: backdrop,
                    poster: poster,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Buttons(
                        icon: Icons.add,
                        onTap: () {},
                      ),
                      Buttons(
                        icon: Icons.favorite_border,
                        onTap: () {},
                      ),
                      Buttons(
                        icon: Icons.download,
                        onTap: () {},
                      ),
                      Buttons(
                        icon: Icons.share,
                        onTap: () {},
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '$title',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('$resume',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            bottomNavigationBar: MoviesNavBar(),
          );
        },
      ),
    );
  }
}
