import 'package:flutter/material.dart';
import 'package:flutter_movie_app/services/auth_services.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40),
            Image.asset(
              'assets/logotipoplanet.png',
              height: 150,
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.movie),
                    title: Text(
                      'Bienvenido....!!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    subtitle: Text(
                        'Contribuir con tu experiencia siempre es un placer, gracias por tu preferencia.'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text(
                          'Salir',
                          style: TextStyle(
                              color: Color.fromARGB(255, 49, 26, 154),
                              fontSize: 18),
                        ),
                        onPressed: () async {
                          await authService.signOut();
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        child: const Text(
                          'Aceptar',
                          style: TextStyle(
                              color: Color.fromARGB(255, 49, 26, 154),
                              fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'home');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
