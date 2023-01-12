import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  void Function()? onTap;
  String texto;

  ButtonLogin({
    required this.texto,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 300,
          height: 52,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromARGB(184, 50, 3, 104).withOpacity(0.8)),
          child: Center(
              child: Text(texto,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)))),
    );
  }
}

class ButtonFillClear extends StatelessWidget {
  void Function()? onTap;
  String texto;

  ButtonFillClear({
    required this.texto,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 100,
          height: 25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.white),
          child: Center(
              child: Text(texto,
                  style: TextStyle(
                      fontSize: 10,
                      color:
                          Color.fromARGB(184, 197, 187, 208).withOpacity(0.8),
                      fontWeight: FontWeight.bold)))),
    );
  }
}
