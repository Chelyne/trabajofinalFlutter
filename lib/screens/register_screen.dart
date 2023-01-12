import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movie_app/services/auth_services.dart';
import 'package:flutter_movie_app/services/firestore_service.dart';
import 'package:flutter_movie_app/widgets/button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);

      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);

      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to take image: $e');
    }
  }

  String? imageUrl = '';

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailControler = TextEditingController();
    final TextEditingController passwordControler = TextEditingController();
    final TextEditingController nombresControler = TextEditingController();
    final TextEditingController apellidosControler = TextEditingController();
    final TextEditingController celularControler = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final authService = Provider.of<AuthService>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Regístrate',
                style: TextStyle(fontSize: 35),
              ),
              const SizedBox(
                height: 5,
              ),
              Column(
                children: [
                  image != null
                      ? Image.file(
                          image!,
                          height: 150,
                        )
                      : Image.asset(
                          'assets/logotipoplanet.png',
                          height: 150,
                        ),
                  Center(
                    child: PopupMenuButton<String>(
                      position: PopupMenuPosition.over,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cameraswitch_outlined),
                          SizedBox(width: 5),
                          Text('Cambiar foto'),
                        ],
                      ),
                      onSelected: (String value) {
                        print(value);
                        //ejecutamos la funciones
                        if (value == 'camara') {
                          pickImageC();
                        } else if (value == 'galeria') {
                          pickImage();
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'camara',
                          child: Row(
                            children: [
                              Icon(Icons.cameraswitch),
                              SizedBox(width: 5),
                              Text('Camara'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'galeria',
                          child: Row(
                            children: [
                              Icon(Icons.photo_album),
                              SizedBox(width: 5),
                              Text('Galeria'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  controller: nombresControler,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese un nombre válido";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Apellidos'),
                  controller: apellidosControler,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese un Apellido válido";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
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
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: passwordControler,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese un contraseña";
                    } else if (value.length <= 6) {
                      return "Ingrese al menos 6 dígitos";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: celularControler,
                  decoration: const InputDecoration(labelText: 'Celular'),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^9[0-9]{8}$').hasMatch(value)) {
                      return "Ingrese un celular válido";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  const Text('No, no quiero ofertas especiales de Planet.')
                ],
              ),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (value) {}),
                  const Text('Acepto los términos, condiciones de Planet.')
                ],
              ),
              ButtonLogin(
                texto: 'Registrarme',
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    if (image == null) {
                      // subir datos sin imagen
                      imageUrl = null;
                    } else {
                      String uniqueFileName =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      //subir Imagen y subir datos
                      //REFERENCIA AL STORAGE
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      //CREA CARPETA EN EL STORAGE
                      Reference referenceDirImages =
                          referenceRoot.child('perfiles');

                      //ASIGNA UN NOMBRE AL ARCHIVO A SUBIR
                      Reference referenceImageToUpload =
                          referenceDirImages.child(uniqueFileName);

                      try {
                        //SUBE LA IMAGEN
                        await referenceImageToUpload.putFile(File(image!.path));
                        //OBTIENE LA URL
                        imageUrl =
                            await referenceImageToUpload.getDownloadURL();
                      } catch (error) {
                        //Some error occurred
                        _showToast(context, 'La imagen no pudo ser subida',
                            Icons.warning, Colors.redAccent);
                      }
                    }
                    var newUser = {
                      'nombres': nombresControler.text,
                      'apellidos': apellidosControler.text,
                      'celular': celularControler.text,
                      'email': emailControler.text,
                      'urlImage': imageUrl,
                    };

                    print('todo esta valido , consulta en firebase');
                    await authService
                        .createUserWithEmailAndPassword(
                            emailControler.text, passwordControler.text)
                        .then((value) => {
                              _showToast(
                                  context,
                                  'Usuario Registrado. INICIE SESION',
                                  Icons.check,
                                  Colors.green),
                              addUsuario(newUser)
                            })
                        .catchError((err) => {print('Error: $err')});
                    Navigator.pop(context);
                  } else {
                    print('No valido');
                    _showToast(context, 'Ingrese Datos Correctamente',
                        Icons.warning, Colors.redAccent);
                  }
                },
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Ya tengo una cuenta. ',
                      style: TextStyle(
                          color: Color.fromARGB(255, 15, 15, 16),
                          fontSize: 15)),
                  const SizedBox(height: 8.0),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Iniciar Sesion',
                        style: TextStyle(
                            color: Color.fromARGB(255, 73, 30, 122),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
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
