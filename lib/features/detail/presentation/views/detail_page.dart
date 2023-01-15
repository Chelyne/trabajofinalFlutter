import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app/features/detail/presentation/views/widgets/comments_movie.dart';
import 'package:flutter_movie_app/features/home/presentation/views/cubit_movieid/movieid_cubit.dart';
import 'package:flutter_movie_app/features/home/presentation/views/widgets/buttons.dart';
import 'package:flutter_movie_app/services/firestore_service.dart';
import 'package:flutter_movie_app/user_preferences.dart';
import 'package:flutter_movie_app/widgets/movies_nav_bar.dart';

import '../../../../widgets/details_header.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;

    Future<dynamic> AlertShowComents(BuildContext context) {
      String? email = UserPreferences.getEmail() ?? '';
      final TextEditingController comentario = TextEditingController();
      final formKeyNewComentario = GlobalKey<FormState>();
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Agregar comentario"),
            content: Form(
              key: formKeyNewComentario,
              child: TextFormField(
                controller: comentario,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Ingrese un comentario";
                  } else if (value.length <= 3) {
                    return "Ingrese al menos 3 caracteres";
                  } else if (value.length >= 200) {
                    return "solo se acepta 200 caracteres";
                  } else {
                    return null;
                  }
                },
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              ElevatedButton(
                child: Text("Guardar"),
                onPressed: () {
                  if (formKeyNewComentario.currentState!.validate()) {
                    var com = {
                      'descripcion': comentario.text,
                      'idPelicula': id,
                      'correo': email,
                      'fechaPublicacion': DateTime.now().toString()
                    };
                    addComentario(com)
                        .then((value) => print('COMENTRAIO OK'))
                        .catchError((err) => print(err));
                    setState(() {});
                    Navigator.of(context).pop();
                  } else {
                    print('ingrese comentario de manera adecuada');
                  }
                },
              ),
            ],
          );
        },
      );
    }

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
              child: SingleChildScrollView(
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
                          onTap: () {
                            AlertShowComents(context);
                          },
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
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommentsMovie(idPelicula: id)
                  ],
                ),
              ),
            ),
            bottomNavigationBar: MoviesNavBar(),
          );
        },
      ),
    );
  }
}
