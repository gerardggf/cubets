import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platjoc/screens/seleccionarnivel.dart';

import '../bloc/infomuertes_bloc.dart';
import '../const.dart';

class FinJuegoScreen extends StatefulWidget {
  const FinJuegoScreen({super.key});

  @override
  State<FinJuegoScreen> createState() => _FinJuegoScreenState();
}

int totalNivelesD = arrayNiveles.length;

class _FinJuegoScreenState extends State<FinJuegoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Niveles",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Text(
              "Felicidades, has superado los $totalNivelesD niveles habiendo muerto ${context.read<InfoMuertesBloc>().state} veces de las $vidas.",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
