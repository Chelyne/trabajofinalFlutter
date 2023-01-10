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

Future<void> updateUsuario(String nombres) async {
  await db
      .collection('usuario')
      .doc('usuarios')
      .update({'nombre': nombres});
}
