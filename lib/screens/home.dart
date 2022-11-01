import 'dart:async';

import 'package:flutter/material.dart';
import 'package:platjoc/objetos/enemigo.dart';
import 'package:platjoc/objetos/jugador.dart';
import 'package:platjoc/objetos/meta.dart';
import 'package:platjoc/objetos/moneda.dart';

import '../const.dart';
import '../niveles.dart';
import '../objetos/pixel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int numPixeles = numFilas * numColumnas;
  int jugador = jugadorPosOrigen;
  int monedasR = 0;
  int posEnemigo = 0;
  bool isJuegoStart = false;
  List<List<int>> nivelA = nivelL1;

  var cont = 0;
  var vidas = 3;

  var nivelLActual = 1;

  void initJuego() {
    Timer.periodic(const Duration(milliseconds: 250), (timer) {
      setState(() {
        posEnemigo = nivelA[2][cont];
      });
      cont++;
      if (cont >= nivelA[2].length) {
        cont = 0;
      }

      derrotado();
      //condicional global por si para el juego
      if (isJuegoStart == false) {
        timer.cancel();
      }
    });
  }

  void load() {
    if (isJuegoStart == false) {
      switch (nivelLActual) {
        case 1:
          {
            nivelA = nivelL1;
            break;
          }
        case 2:
          {
            nivelA = nivelL2;
            break;
          }
        case 3:
          {
            nivelA = nivelL3;
            break;
          }
        case 4:
          {
            nivelA = nivelL4;
            break;
          }
        case 5:
          {
            nivelA = nivelL5;
            break;
          }
        case 6:
          {
            nivelA = nivelL6;
            break;
          }
      }
      setState(() {
        nivelA;
        jugador = jugadorPosOrigen;
      });
    }
  }

  void startJuego(int vPos) {
    if (isJuegoStart == false) {
      load();
      initJuego();

      isJuegoStart = true;
    }

    switch (vPos) {
      case 0:
        {
          if (nivelA[1].contains(jugador - numFilas)) {
            monedasR++;
            nivelA[1].remove(jugador - numFilas);
          }
          if (!nivelA[0].contains(jugador - numFilas)) {
            setState(() {
              jugador = jugador - numFilas;
            });
          }
        }
        break;
      case 1:
        {
          if (nivelA[1].contains(jugador - 1)) {
            monedasR++;
            nivelA[1].remove(jugador - 1);
          }
          if (!nivelA[0].contains(jugador - 1)) {
            setState(() {
              jugador--;
            });
          }
        }
        break;
      case 2:
        {
          if (nivelA[1].contains(jugador + 1)) {
            monedasR++;
            nivelA[1].remove(jugador + 1);
          }
          if (!nivelA[0].contains(jugador + 1)) {
            setState(() {
              jugador++;
            });
          }
        }
        break;
      case 3:
        if (nivelA[1].contains(jugador + numFilas)) {
          monedasR++;
          nivelA[1].remove(jugador + numFilas);
        }
        if (!nivelA[0].contains(jugador + numFilas)) {
          setState(() {
            jugador = jugador + numFilas;
          });
        }

        break;
    }

    derrotado();
    if (jugador == nivelA[3][0]) {
      meta();
    }
  }

  void derrotado() {
    if (jugador == posEnemigo) {
      isJuegoStart = false;
      vidas--;
      load();
      if (vidas == 0) {
        isJuegoStart == false;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    }
  }

  void meta() {
    if (monedasR == 4) {
      isJuegoStart = false;
      nivelLActual++;

      load();
      monedasR = 0;

      print("Nivel $nivelLActual");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(children: [
        Expanded(
          flex: 2,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: numPixeles,
            itemBuilder: (BuildContext context, int index) {
              var indexString = index.toString();
              //var indexString = "";

              if (jugador == index) {
                return (Jugador(
                    vColor: Colors.orange,
                    vChild: Text(indexString,
                        style: const TextStyle(color: Colors.white))));
              } else if (nivelA[0].contains(index)) {
                return (Pixel(
                    vColor: Colors.blue,
                    vChild: Text(indexString,
                        style: const TextStyle(color: Colors.white))));
              } else if (nivelA[1].contains(index)) {
                return Moneda(
                    vColor: Colors.yellow,
                    vChild: Text(indexString,
                        style: const TextStyle(color: Colors.white)));
              } else if (posEnemigo == index) {
                return Enemigo(
                    vColor: Colors.red,
                    vChild: Text(indexString,
                        style: const TextStyle(color: Colors.white)));
              } else if (nivelA[3][0] == index) {
                return Meta(
                    vColor: Colors.white,
                    vChild: Text(indexString,
                        style: const TextStyle(color: Colors.white)));
              } else {
                return (Pixel(
                    vColor: kBackgroundColor,
                    vChild: Text(indexString,
                        style: const TextStyle(color: Colors.white))));
              }
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: numFilas),
          ),
        ),
        Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    startJuego(0);
                  },
                  child: const Icon(
                    Icons.arrow_drop_up,
                    size: kBtnSize,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        startJuego(1);
                      },
                      child: const Icon(
                        Icons.arrow_left,
                        size: kBtnSize,
                      ),
                    ),
                    const SizedBox(
                      width: 90,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        startJuego(2);
                      },
                      child: const Icon(
                        Icons.arrow_right,
                        size: kBtnSize,
                      ),
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    startJuego(3);
                  },
                  child: const Icon(
                    Icons.arrow_drop_down,
                    size: kBtnSize,
                  ),
                ),
                Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(kPaddingText),
                    child: Row(
                      children: [
                        Text(
                          "Nivel $nivelLActual",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Monedas: ${monedasR.toString()}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Vidas restantes: ${vidas.toString()}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        // const SizedBox(
                        //   width: 20,
                        // ),
                        // TextButton(
                        //     onPressed: () {
                        //       isJuegoStart = false;
                        //       nivelLActual = 1;
                        //       load();
                        //     },
                        //     child: const Text(
                        //       "Reiniciar",
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.white),
                        //     )),
                      ],
                    ))
              ],
            ))
      ]),
    );
  }
}
