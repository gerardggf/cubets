import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platjoc/bloc/infonivel_bloc.dart';
import 'package:platjoc/const.dart';
import 'package:platjoc/screens/home.dart';

import '../models.dart';
import '../niveles.dart';

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
        body: BlocBuilder<InfoNivelBloc, int>(
            builder: (context, uNivel) => ListView.builder(
                itemCount: uNivel + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index > 0 && index <= 4) {
                    colorNivel = Colors.yellow;
                  } else if (index >= 5 && index <= 9) {
                    colorNivel = Colors.lightGreen;
                  } else if (index >= 10 && index <= 14) {
                    colorNivel = Colors.lightBlue;
                  } else if (index >= 15 && index <= 19) {
                    colorNivel = Colors.orange;
                  } else if (index >= 20 && index <= 24) {
                    colorNivel = Colors.redAccent;
                  } else if (index >= 25 && index <= 29) {
                    colorNivel = Colors.purple;
                  } else if (index >= 30 && index <= 40) {
                    colorNivel = Colors.black;
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
                        nivelLActual = index;
                        isJuegoStart = false;
                        setState(() {
                          nivelLActual;
                        });
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      },
                    ),
                  );
                })));
  }
}

mappearNiveles() {
  final nivelF0 = tutorial;
  final nivelF1 = e1d01f01;
  final nivelF2 = e1d01f02;
  final nivelF3 = e1d01f03;
  final nivelF4 = e1d02f03;
  final nivelF5 = e1d03f03;
  final nivelF6 = e1d03f04;
  final nivelF7 = e1d04f03;
  final nivelF8 = e2d04f01;
  final nivelF9 = e2d04f04;
  final nivelF10 = e1d05f03;
  final nivelF11 = e1d05f04;
  final nivelF12 = e3d05f03;
  final nivelF13 = e1d06f03;
  final nivelF14 = e1d06f04;
  final nivelF15 = e2d06f04;
  final nivelF16 = e1d07f03;
  final nivelF17 = e3d07f03;
  final nivelF18 = e3d07f04;
  final nivelF19 = e2d08f04;
  final nivelF20 = e3d08f04;
  final nivelF21 = e3d08f05;
  final nivelF22 = e3d09f02;
  final nivelF23 = tutorial;
  final nivelF24 = tutorial;
  final nivelF25 = tutorial;
  final nivelF26 = tutorial;
  final nivelF27 = tutorial;
  final nivelF28 = tutorial;
  final nivelF29 = tutorial;
  final nivelF30 = tutorial;
  final nivelF31 = tutorial;
  final nivelF32 = tutorial;
  final nivelF33 = tutorial;
  final nivelF34 = tutorial;
  final nivelF35 = tutorial;
  final nivelF36 = tutorial;
  final nivelF37 = tutorial;
  final nivelF38 = tutorial;
  final nivelF39 = tutorial;
  final nivelF40 = tutorial;

  switch (nivelLActual) {
    case 0:
      {
        nivelA = nivelF0;
        break;
      }
    case 1:
      {
        nivelA = nivelF1;
        break;
      }
    case 2:
      {
        nivelA = nivelF2;
        break;
      }
    case 3:
      {
        nivelA = nivelF3;
        break;
      }
    case 4:
      {
        nivelA = nivelF4;
        break;
      }
    case 5:
      {
        nivelA = nivelF5;
        break;
      }
    case 6:
      {
        nivelA = nivelF6;
        break;
      }
    case 7:
      {
        nivelA = nivelF7;
        break;
      }
    case 8:
      {
        nivelA = nivelF8;
        break;
      }
    case 9:
      {
        nivelA = nivelF9;
        break;
      }
    case 10:
      {
        nivelA = nivelF10;
        break;
      }
    case 11:
      {
        nivelA = nivelF11;
        break;
      }
    case 12:
      {
        nivelA = nivelF12;
        break;
      }
    case 13:
      {
        nivelA = nivelF13;
        break;
      }
    case 14:
      {
        nivelA = nivelF14;
        break;
      }
    case 15:
      {
        nivelA = nivelF15;
        break;
      }
    case 16:
      {
        nivelA = nivelF16;
        break;
      }
    case 17:
      {
        nivelA = nivelF17;
        break;
      }
    case 18:
      {
        nivelA = nivelF18;
        break;
      }
    case 19:
      {
        nivelA = nivelF19;
        break;
      }
    case 20:
      {
        nivelA = nivelF20;
        break;
      }
    case 21:
      {
        nivelA = nivelF21;
        break;
      }
    case 22:
      {
        nivelA = nivelF22;
        break;
      }
    case 23:
      {
        nivelA = nivelF23;
        break;
      }
    case 24:
      {
        nivelA = nivelF24;
        break;
      }
    case 25:
      {
        nivelA = nivelF25;
        break;
      }
    case 26:
      {
        nivelA = nivelF26;
        break;
      }
    case 27:
      {
        nivelA = nivelF27;
        break;
      }
    case 28:
      {
        nivelA = nivelF28;
        break;
      }
    case 29:
      {
        nivelA = nivelF29;
        break;
      }
    case 30:
      {
        nivelA = nivelF30;
        break;
      }
    case 31:
      {
        nivelA = nivelF31;
        break;
      }
    case 32:
      {
        nivelA = nivelF32;
        break;
      }
    case 33:
      {
        nivelA = nivelF33;
        break;
      }
    case 34:
      {
        nivelA = nivelF34;
        break;
      }
    case 35:
      {
        nivelA = nivelF35;
        break;
      }
    case 36:
      {
        nivelA = nivelF36;
        break;
      }
    case 37:
      {
        nivelA = nivelF37;
        break;
      }
    case 38:
      {
        nivelA = nivelF38;
        break;
      }
    case 39:
      {
        nivelA = nivelF39;
        break;
      }
    case 40:
      {
        nivelA = nivelF40;
        break;
      }
  }
}
