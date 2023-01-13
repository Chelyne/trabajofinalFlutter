import 'package:flutter/material.dart';
import 'package:flutter_movie_app/models/profile_user.dart';
import 'package:flutter_movie_app/services/firestore_service.dart';
import 'package:flutter_movie_app/user_preferences.dart';

class DetailsProfile extends StatefulWidget {
  const DetailsProfile({super.key});

  @override
  State<DetailsProfile> createState() => _DetailsProfileState();
}

class _DetailsProfileState extends State<DetailsProfile> {
  ProfileUser? currentUser;
  final _formkey = GlobalKey<FormState>();

  final nombresCtrl = TextEditingController();
  final apellidosCtrl = TextEditingController();
  final celularCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  String id = '';

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
              nombresCtrl.text = user[0]['nombres'];
              apellidosCtrl.text = user[0]['apellidos'];
              celularCtrl.text = user[0]['celular'];
              emailCtrl.text = user[0]['email'];
              id = user[0]['id'];
              print('ID' + id);
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
        Padding(
          padding: const EdgeInsets.only(top: 320),
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese Nombres';
                        } else if (value.length <= 3) {
                          return "Ingrese un nombre correctamente";
                        } else {
                          return null;
                        }
                      },
                      controller: nombresCtrl,
                      enableInteractiveSelection: false,
                      autofocus: true,
                      decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 85, 84, 80),
                          filled: true,
                          labelText: 'Nombres',
                          suffix: const Icon(Icons.verified_user,
                              color: Colors.white),
                          labelStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.purple, width: 1.0),
                            borderRadius: BorderRadius.circular(15.0),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese Apellidos';
                        } else if (value.length <= 3) {
                          return "Ingrese sus apellidos correctamente";
                        } else {
                          return null;
                        }
                      },
                      controller: apellidosCtrl,
                      enableInteractiveSelection: false,
                      autofocus: true,
                      decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 85, 84, 80),
                          filled: true,
                          labelText: 'Apellidos',
                          suffix: const Icon(Icons.verified_user,
                              color: Colors.white),
                          labelStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.purple, width: 1.0),
                            borderRadius: BorderRadius.circular(15.0),
                          )),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: celularCtrl,
                      enableInteractiveSelection: false,
                      autofocus: true,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^9[0-9]{8}$').hasMatch(value)) {
                          return "Ingrese un celular válido";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 85, 84, 80),
                          filled: true,
                          labelText: 'Celular',
                          suffix: const Icon(Icons.verified_user,
                              color: Colors.white),
                          labelStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.purple, width: 1.0),
                            borderRadius: BorderRadius.circular(15.0),
                          )),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      readOnly: true,
                      style: const TextStyle(color: Colors.white),
                      controller: emailCtrl,
                      enableInteractiveSelection: false,
                      autofocus: true,
                      decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 85, 84, 80),
                          filled: true,
                          labelText: 'Correo',
                          suffix: const Icon(Icons.verified_user,
                              color: Colors.white),
                          labelStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.purple, width: 1.0),
                            borderRadius: BorderRadius.circular(15.0),
                          )),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            //VALIDAR DATOS Y CAMBIAR
                            updateUsuario(id, nombresCtrl.text,
                                    apellidosCtrl.text, celularCtrl.text)
                                .then((value) {
                              _showToast(
                                  context,
                                  'Datos actualizados correctamente',
                                  Icons.warning,
                                  Colors.green);
                            }).catchError((onError) {
                              _showToast(
                                  context,
                                  'Error, no se pudo actualizar los datos',
                                  Icons.warning,
                                  Colors.redAccent);
                            });
                          } else {
                            _showToast(context, 'Ingrese Datos Correctamente',
                                Icons.warning, Colors.redAccent);
                          }
                        },
                        child: const Text('Actualizar')),
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
            ),
            const Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 30,
            ),
          ],
        ),
      ],
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
