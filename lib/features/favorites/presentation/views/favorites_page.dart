import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app/features/home/presentation/views/cubit_movieid/movieid_cubit.dart';
import 'package:flutter_movie_app/services/firestore_service.dart';
import 'package:flutter_movie_app/user_preferences.dart';
import 'package:flutter_movie_app/widgets/movies_nav_bar.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String? email;
  // List ListFavorites = [];
  void initState() {
    // TODO: implement initState
    super.initState();
    email = UserPreferences.getEmail() ?? '';
    // getFavoritosUser(email ?? '').then((value) {
    //   ListFavorites = value;
    //   print(ListFavorites);
    // }).catchError((err) => ListFavorites = []);
  }

  @override
  Widget build(BuildContext context) {
    print('correoFavorito' + email!);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('FAVORITOS'),
      ),
      //body: CardFavorite('76600')
      body: FutureBuilder(
          future: getFavoritosUser(email ?? ''),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return CardFavorite(snapshot.data?[index]['idPelicula']);
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      bottomNavigationBar: MoviesNavBar(),
    );
  }
}

BlocProvider<MovieIdCubit> CardFavorite(String id) {
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
        print(
            '-------------------------------------------------------------------------------------');

        return CardMovie(imagen: poster, titulo: title);
      },
    ),
  );
}

class CardMovie extends StatelessWidget {
  final String imagen;
  final String titulo;

  const CardMovie({
    Key? key,
    required this.imagen,
    required this.titulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 3,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              imagen != null
                  ? FadeInImage.assetNetwork(
                      placeholder: 'assets/logotipoplanet.png',
                      image: 'https://image.tmdb.org/t/p/w500$imagen',
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.20,
                      fit: BoxFit.fill,
                    )
                  : Image.asset(
                      'assets/logotipoplanet.png',
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.20,
                      fit: BoxFit.fill,
                    ),
              Text(
                titulo,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 2, 2, 2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
