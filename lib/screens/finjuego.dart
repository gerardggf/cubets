import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platjoc/screens/seleccionarnivel.dart';

import '../bloc/infomuertes_bloc.dart';
import '../const.dart';
import 'gameover.dart';

class FinJuegoScreen extends StatefulWidget {
  const FinJuegoScreen({super.key});

  @override
  State<FinJuegoScreen> createState() => _FinJuegoScreenState();
}

int totalNivelesD = arrayNiveles.length - 1;

class _FinJuegoScreenState extends State<FinJuegoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kColor,
          title: const Text(
            "Cubets",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "¡Felicidades!",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Fin del juego. Has superado los $totalNivelesD niveles habiendo muerto un total de ${context.read<InfoMuertesBloc>().state} veces.",
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/img/icono_cubets.png",
                width: 100,
                height: 100,
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Puntuación:",
                style: TextStyle(fontSize: 25),
              ),
              Text(
                fPuntuacion.toString(),
                style: const TextStyle(
                    fontSize: 50, fontWeight: FontWeight.bold, color: kColor),
              ),
            ],
          ),
        ));
  }
}
