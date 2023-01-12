import 'package:flutter/material.dart';
import 'package:flutter_movie_app/models/profile_user.dart';
import 'package:flutter_movie_app/services/firestore_service.dart';
import 'package:flutter_movie_app/user_preferences.dart';

class HeaderHome extends StatefulWidget {
  const HeaderHome({
    Key? key,
  }) : super(key: key);

  @override
  State<HeaderHome> createState() => _HeaderHomeState();
}

class _HeaderHomeState extends State<HeaderHome> {
  ProfileUser? currentUser;
  @override
  void initState() {
    super.initState();
    Future.sync(() async {
      String? email = UserPreferences.getEmail() ?? '';
      print('EMAILLL SHARED PREFERENCES home' + email);
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Bienvenido: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 28,
                    ),
                  ),
                  Text(
                    (currentUser?.nombres).toString().toUpperCase() ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      fontSize: 26,
                    ),
                  ),
                ],
              ),
              Text(
                'What to watch?',
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                currentUser?.urlImage ??
                    'https://laverdadnoticias.com/__export/1655819964975/sites/laverdad/img/2022/06/21/spy_x_family_viral_anya_forger_con_rasgos_biologicos_de_loid_y_yor.jpeg_1899857922.jpeg',
                height: 50,
                width: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
