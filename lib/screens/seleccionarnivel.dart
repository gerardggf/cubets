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

var colorNivel = Colors.white;

class _SeleccionarNivelState extends State<SeleccionarNivel> {
  double gridPadding = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kColor,
          title: const Text(
            "Niveles",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder<InfoNivelBloc, int>(
            builder: (context, uNivel) => Padding(
                  padding: EdgeInsets.all(gridPadding),
                  child: GridView.builder(
                    itemCount: uNivel + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index > 0 && index <= 4) {
                        colorNivel = kColor.withOpacity(0.2);
                      } else if (index >= 5 && index <= 9) {
                        colorNivel = kColor.withOpacity(0.35);
                      } else if (index >= 10 && index <= 14) {
                        colorNivel = kColor.withOpacity(0.5);
                      } else if (index >= 15 && index <= 19) {
                        colorNivel = kColor.withOpacity(0.65);
                      } else if (index >= 20 && index <= 24) {
                        colorNivel = kColor.withOpacity(0.8);
                      } else if (index >= 25 && index <= 29) {
                        colorNivel = kColor.withOpacity(0.9);
                      } else if (index >= 30 && index <= 40) {
                        colorNivel = kColor.withOpacity(1);
                      } else {
                        colorNivel = Colors.white;
                      }
                      return GestureDetector(
                          child: Container(
                            decoration: index == nivelLActual
                                ? BoxDecoration(
                                    color: colorNivel,
                                    border: Border.all(
                                        width: 4.0, color: Colors.amberAccent),
                                    borderRadius: BorderRadius.circular(10))
                                : BoxDecoration(
                                    color: colorNivel,
                                    borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.only(
                                top: kPadding,
                                bottom: kPadding,
                                left: kPadding),
                            child: GridTile(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Nivel",
                                      style: TextStyle(fontSize: kFSize)),
                                  if (index == 0)
                                    const Text(
                                      "Tutorial",
                                      style: TextStyle(
                                          fontSize: kFSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  if (index != 0)
                                    Text(
                                      index.toString(),
                                      style: const TextStyle(
                                          fontSize: kFSize + 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                ],
                              ),
                            ),
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
                          });
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: gridPadding,
                      mainAxisSpacing: gridPadding,
                    ),
                  ),
                )));
  }
}

//===========================================================================================================
List<Map<String, dynamic>> arrayNiveles = [
  d00i000,
  d01i001,
  d01i002,
  d01i027,
  d01i005,
  d01i025,
  d01i003,
  d02i026,
  d03i006, d03i029,
  d02i004,
  d03i023, d03i028,
  d04i007,
  d04i008,
  d04i009,
  d05i010,
  d05i011,
  d05i012,
  d06i013,
  d06i014,
  d06i015,
  d09i024,
  d06i021,
  d07i016,
  d07i020,
  d07i017,
  d07i018,
  d08i019,
  d09i022,

  //orden real hasta aquí

  //final00
  d00ifinal
];
//===========================================================================================================

mappearNiveles() {
  final nivelF0 = arrayNiveles[0];
  final nivelF1 = arrayNiveles[1];
  final nivelF2 = arrayNiveles[2];
  final nivelF3 = arrayNiveles[3];
  final nivelF4 = arrayNiveles[4];
  final nivelF5 = arrayNiveles[5];
  final nivelF6 = arrayNiveles[6];
  final nivelF7 = arrayNiveles[7];
  final nivelF8 = arrayNiveles[8];
  final nivelF9 = arrayNiveles[9];
  final nivelF10 = arrayNiveles[10];
  final nivelF11 = arrayNiveles[11];
  final nivelF12 = arrayNiveles[12];
  final nivelF13 = arrayNiveles[13];
  final nivelF14 = arrayNiveles[14];
  final nivelF15 = arrayNiveles[15];
  final nivelF16 = arrayNiveles[16];
  final nivelF17 = arrayNiveles[17];
  final nivelF18 = arrayNiveles[18];
  final nivelF19 = arrayNiveles[19];
  final nivelF20 = arrayNiveles[20];
  final nivelF21 = arrayNiveles[21];
  final nivelF22 = arrayNiveles[22];
  final nivelF23 = arrayNiveles[23];
  final nivelF24 = arrayNiveles[24];
  final nivelF25 = arrayNiveles[25];
  final nivelF26 = arrayNiveles[26];
  final nivelF27 = arrayNiveles[27];
  final nivelF28 = arrayNiveles[28];
  final nivelF29 = arrayNiveles[29];
  final nivelF30 = arrayNiveles[30];

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
  }
}
