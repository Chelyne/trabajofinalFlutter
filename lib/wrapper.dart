import 'package:flutter/material.dart';
import 'package:flutter_movie_app/features/home/presentation/views/home_page.dart';
import 'package:flutter_movie_app/models/user_model.dart';
import 'package:flutter_movie_app/screens/login_screen.dart';
import 'package:flutter_movie_app/screens/screens.dart';
import 'package:flutter_movie_app/services/auth_services.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          print('user: $user');
          return user == null ? LoginScreen() : HomePage();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
