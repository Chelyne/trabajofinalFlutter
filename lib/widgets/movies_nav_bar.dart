import 'package:flutter/material.dart';
import 'package:flutter_movie_app/services/auth_services.dart';
import 'package:provider/provider.dart';

class MoviesNavBar extends StatelessWidget {
  const MoviesNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 13),
      margin: const EdgeInsets.only(top: 8, right: 5, left: 5),
      decoration: const BoxDecoration(
        color: Color(0xFF292B37),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'home');
            },
            child: const Icon(
              Icons.home,
              size: 35,
              color: Colors.white,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'details');
            },
            child: const Icon(
              Icons.category,
              size: 35,
              color: Colors.white,
            ),
          ),
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.favorite_border,
              size: 35,
              color: Colors.white,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: const Icon(
              Icons.person,
              size: 35,
              color: Colors.white,
            ),
          ),
          InkWell(
            onTap: () async {
              await authService.signOut();
              //Navigator.pushNamed(context, '/login');
            },
            child: const Icon(
              Icons.logout,
              size: 35,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
