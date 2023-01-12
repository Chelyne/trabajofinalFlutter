import 'package:flutter/material.dart';
import 'package:flutter_movie_app/services/auth_services.dart';
import 'package:flutter_movie_app/user_preferences.dart';
import 'package:flutter_movie_app/widgets/button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailControler = TextEditingController();
    final TextEditingController passwordControler = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final authService = Provider.of<AuthService>(context);
    void storeEmail(String email) async {
      await UserPreferences.setEmail(email);
    }

    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logotipoplanet.png',
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: emailControler,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                    return "Ingrese un correo válido";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: passwordControler,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Ingrese una contraseña";
                  } else if (value.length <= 6) {
                    return "Ingrese al menos 6 dígitos";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            ButtonLogin(
                texto: 'Login',
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    print('todo esta valido , consulta en firebase');
                    await authService
                        .signInWithEmailAndPassword(
                            emailControler.text, passwordControler.text)
                        .then((value) => {
                              storeEmail(emailControler.text),
                              _showToast(context, 'Datos válidos', Icons.check,
                                  Colors.green)
                            })
                        .catchError((err) => {print('Error: $err')});
                  } else {
                    print('No valido');
                    _showToast(context, 'Ingrese Datos Correctamente',
                        Icons.warning, Colors.redAccent);
                  }
                }),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('No tienes una cuenta? '),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      'Regístrate',
                      style: TextStyle(
                          color: Color.fromARGB(255, 49, 26, 154),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showToast(
      BuildContext context, String texto, IconData icono, Color color) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icono),
            Text(texto),
          ],
        ),
        action: SnackBarAction(
            textColor: Color.fromARGB(255, 4, 4, 4),
            label: 'Ok',
            onPressed: scaffold.hideCurrentSnackBar),
        backgroundColor: color,
      ),
    );
  }
}
