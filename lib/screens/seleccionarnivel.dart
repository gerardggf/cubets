import 'package:flutter/material.dart';
import 'package:platjoc/screens/home.dart';

class SeleccionarNivel extends StatefulWidget {
  const SeleccionarNivel({super.key});

  @override
  State<SeleccionarNivel> createState() => _SeleccionarNivelState();
}

class _SeleccionarNivelState extends State<SeleccionarNivel> {
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
            padding: const EdgeInsets.all(8),
            itemCount: uNivel,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text("Nivel ${index + 1}"),
                onTap: () {
                  isJuegoStart = false;
                  nivelLActual = index + 1;
                  setState(() {
                    nivelLActual;
                  });
                  Navigator.of(context).pop();
                },
              );
            }));
  }
}
