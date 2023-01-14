import 'package:flutter/material.dart';
import 'package:flutter_movie_app/services/firestore_service.dart';

class CommentsMovie extends StatefulWidget {
  const CommentsMovie({super.key});

  @override
  State<CommentsMovie> createState() => _CommentsMovieState();
}

class _CommentsMovieState extends State<CommentsMovie> {
  final TextEditingController comentario = TextEditingController();
  final formKeyNewComentario = GlobalKey<FormState>();
  String? idMovie;
  void initState() {
    // TODO: implement initState
    super.initState();
    idMovie = '123456';
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder(
      future: getComentariosPeliculas(idMovie ?? ' '),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: ((context, index) {
              return Container(
                child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: PopupMenuButton<String>(
                      position: PopupMenuPosition.over,
                      onSelected: (String value) {
                        print(value);
                        if (value == 'eliminar') {
                          // Eliminar
                          print(
                              'eliminar: ${snapshot.data?[index]['id'].toString()}');
                          deleteComentario(
                                  snapshot.data?[index]['id'].toString() ?? '')
                              .then((value) => {print('Prestamo eliminado')})
                              .catchError((err) => print('Error: $err'));
                          setState(() {});
                        }
                        if (value == 'editar') {
                          AlertShowComents(
                              context,
                              snapshot.data?[index]['id'].toString() ?? '',
                              snapshot.data?[index]['descripcion']);
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'eliminar',
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              SizedBox(width: 5),
                              Text('Eliminar'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'editar',
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.green,
                              ),
                              SizedBox(width: 5),
                              Text('editar'),
                            ],
                          ),
                        ),
                      ],
                      child: Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.money,
                            color: Colors.blue,
                          ),
                          trailing: Text(
                            'S/. ${snapshot.data?[index]['correo'].toString()}',
                            style: TextStyle(fontSize: 20),
                          ),
                          title: Text(
                            snapshot.data?[index]['descripcion'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data?[index]['idPelicula'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
              );
            }),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }

  Future<dynamic> AlertShowComents(
      BuildContext context, String idComent, String coment) {
    setState(() {
      comentario.text = coment;
    });
    print(idComent);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Editar comentario"),
          content: Form(
            key: formKeyNewComentario,
            child: TextFormField(
              controller: comentario,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Ingrese un comentario";
                } else if (value.length <= 3) {
                  return "Ingrese al menos 3 caracteres";
                } else if (value.length >= 75) {
                  return "solo se acepta 75 caracteres";
                } else {
                  return null;
                }
              },
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            ElevatedButton(
              child: Text("Guardar"),
              onPressed: () {
                if (formKeyNewComentario.currentState!.validate()) {
                  print('ID =' + idComent);
                  updateComentario(idComent, comentario.text)
                      .then((value) => print('COMENTARIO OK'))
                      .catchError((err) => print(err));
                  Navigator.of(context).pop();
                  setState(() {});
                } else {
                  print('ingrese comentario de manera adecuada');
                }
              },
            ),
          ],
        );
      },
    );
  }
}
