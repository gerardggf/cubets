import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:platjoc/const.dart';
import 'package:platjoc/screens/home.dart';

class SeleccionarNivel extends StatefulWidget {
  const SeleccionarNivel({super.key});

  @override
  State<SeleccionarNivel> createState() => _SeleccionarNivelState();
}

class _SeleccionarNivelState extends State<SeleccionarNivel> {
  var colorNivel = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Niveles",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.builder(
            itemCount: uNivel! + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index > 0 && index <= 4) {
                colorNivel = Colors.yellow;
              } else if (index >= 5 && index <= 9) {
                colorNivel = Colors.lightGreen;
              } else if (index >= 10 && index <= 14) {
                colorNivel = Colors.lightBlue;
              } else if (index >= 15 && index <= 20) {
                colorNivel = Colors.redAccent;
              } else {
                colorNivel = Colors.white;
              }
              return Ink(
                padding: const EdgeInsets.only(
                    top: kPadding, bottom: kPadding, left: kPadding + 10),
                color: colorNivel,
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (index == 0) const Text("Tutorial"),
                      if (index != 0) Text("Nivel $index")
                    ],
                  ),
                  onTap: () {
                    isJuegoStart = false;
                    nivelLActual = index;
                    setState(() {
                      nivelLActual;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              );
            }));
  }
}
