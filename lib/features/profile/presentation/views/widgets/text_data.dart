import 'package:flutter/material.dart';

class TextData extends StatelessWidget {
  final String texto;
  final IconData icono;
  const TextData({required this.texto, required this.icono, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icono,
            color: Colors.white,
            size: 30,
          ),
          Text(
            texto,
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ],
      ),
    );
  }
}
