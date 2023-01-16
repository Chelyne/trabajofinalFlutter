import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
//................USUARIOS.....................

Future<void> addUsuario(newUser) async {
  await db.collection('usuarios').add(newUser);
}

Future<void> updateUsuario(
    String id, String nombres, String apellidos, String celular) async {
  await db.collection('usuarios').doc(id).update({
    'nombres': nombres,
    'apellidos': apellidos,
    'celular': celular,
  });
}

Future<List> getDataUser(String correo) async {
//Letura de datos
  List listUser = [];
  CollectionReference collectionReference = db.collection('usuarios');
  QuerySnapshot querySnapshot =
      await collectionReference.where('email', isEqualTo: correo).get();
  querySnapshot.docs.forEach((element) {
    Map data = element.data() as Map;
    data['id'] = element.id;
    listUser.add(data);
  });
  Future.delayed(const Duration(seconds: 5));
  return listUser;
}

// .................COMENTARIOS......................

//Obtener comentario de peliculas con su id de la pelicula
Future<List> getComentariosPeliculas(String idPelicula) async {
  //Letura de datos
  List lista = [];
  CollectionReference collectionReference = db.collection('comentarios');
  QuerySnapshot querySnapshot = await collectionReference
      .where('idPelicula', isEqualTo: idPelicula)
      .get();
  querySnapshot.docs.forEach((element) {
    Map data = element.data() as Map;
    data['id'] = element.id;
    lista.add(data);
  });
  Future.delayed(const Duration(seconds: 5));
  return lista;
}

//agregar un nuevo comentario a la pelicula con id de pelicula
Future<void> addComentario(newComentario) async {
  await db.collection('comentarios').add(newComentario);
}

// Actualizar un comentario del usuario
Future<void> updateComentario(String idComentario, String descripcion) async {
  await db
      .collection('comentarios')
      .doc(idComentario)
      .update({
        'descripcion': descripcion,
      })
      .then((value) => print('Cambiado Correctamente'))
      .catchError((err) => print('Error: $err'));
}

// Eliminar comentario
Future<void> deleteComentario(String id) async {
  await db
      .collection('comentarios')
      .doc(id)
      .delete()
      .then((value) => print('Eliminado Correctamente'))
      .catchError((err) => print('Error: $err'));
}
// .................FAVORITOS......................

//Obtener favoritos de peliculas con su correo de usuario
Future<List> getFavoritosUser(String emailUser) async {
  print(emailUser);
  //Letura de datos
  List lista = [];
  CollectionReference collectionReference = db.collection('favoritos');
  QuerySnapshot querySnapshot =
      await collectionReference.where('correo', isEqualTo: emailUser).get();
  querySnapshot.docs.forEach((element) {
    Map data = element.data() as Map;
    print('DATOS OBTENIDOS' + element.data().toString());
    data['id'] = element.id;
    lista.add(data);
  });
  Future.delayed(const Duration(seconds: 5));
  return lista;
}

//agregar un nuevo comentario a la pelicula con id de pelicula
Future<void> addFavorito(newComentario) async {
  await db.collection('favoritos').add(newComentario);
}

// Eliminar comentario
Future<void> deleteFavorito(String id) async {
  await db
      .collection('favoritos')
      .doc(id)
      .delete()
      .then((value) => print('Eliminado Correctamente'))
      .catchError((err) => print('Error: $err'));
}
