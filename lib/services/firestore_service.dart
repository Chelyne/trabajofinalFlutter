import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getLista() async {
//Letura de datos
  List pe = [];
  CollectionReference collectionReference = db.collection('usuarios');
  QuerySnapshot querySnapshot = await collectionReference.get();
  querySnapshot.docs.forEach((element) {
    pe.add(element.data());
  });
  Future.delayed(const Duration(seconds: 5));
  return pe;
}

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
