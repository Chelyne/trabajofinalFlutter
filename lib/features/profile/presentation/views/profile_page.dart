import 'package:flutter/material.dart';
import 'package:flutter_movie_app/features/profile/presentation/views/widgets/details_profile.dart';
import 'package:flutter_movie_app/widgets/movies_nav_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              const DetailsProfile(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MoviesNavBar(),

      //bottomNavigationBar: const MoviesNavBar(),
    );
  }
}
