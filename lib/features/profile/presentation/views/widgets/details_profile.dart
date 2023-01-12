import 'package:flutter/material.dart';
import 'package:flutter_movie_app/features/profile/presentation/views/widgets/text_data.dart';
import 'package:flutter_movie_app/models/profile_user.dart';
import 'package:flutter_movie_app/services/firestore_service.dart';
import 'package:flutter_movie_app/user_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsProfile extends StatefulWidget {
  const DetailsProfile({super.key});

  @override
  State<DetailsProfile> createState() => _DetailsProfileState();
}

class _DetailsProfileState extends State<DetailsProfile> {
  ProfileUser? currentUser;
  @override
  void initState() {
    super.initState();
    Future.sync(() async {
      String? email = UserPreferences.getEmail() ?? '';
      print('EMAILLL SHARED PREFERENCES' + email);
      getDataUser(email).then((user) => {
            print('Usuario' + user.toString()),
            setState(() {
              currentUser = ProfileUser(
                  user[0]['email'],
                  user[0]['nombres'],
                  user[0]['apellidos'],
                  user[0]['celular'],
                  user[0]['urlImage']);
            }),
          });
    }).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.80,
        ),
        ClipRRect(
            child: Image.network(
          'https://acf.geeknetic.es/imgri/imagenes/tutoriales/2020/1759-plataformas-streaming/muestra.jpg?f=webp',
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.35,
          fit: BoxFit.cover,
        )),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.18,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ClipRRect(
                    child: Image.network(
                  currentUser?.urlImage ??
                      'https://laverdadnoticias.com/__export/1655819964975/sites/laverdad/img/2022/06/21/spy_x_family_viral_anya_forger_con_rasgos_biologicos_de_loid_y_yor.jpeg_1899857922.jpeg',
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.height * 0.28,
                  fit: BoxFit.contain,
                )),
              ),
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.48,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextData(texto: currentUser?.nombres ?? '', icono: Icons.person),
              TextData(
                  texto: currentUser?.apellidos ?? '', icono: Icons.person),
              TextData(texto: currentUser?.email ?? '', icono: Icons.email),
              TextData(
                  texto: currentUser?.celular ?? '',
                  icono: Icons.phone_android),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
            ),
            Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 30,
            ),
          ],
        ),
      ],
    );
  }
}
