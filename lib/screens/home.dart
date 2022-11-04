import 'dart:async';

import 'package:flutter/material.dart';
import 'package:platjoc/objetos/enemigo.dart';
import 'package:platjoc/objetos/jugador.dart';
import 'package:platjoc/objetos/meta.dart';
import 'package:platjoc/objetos/moneda.dart';
import 'package:platjoc/screens/seleccionarnivel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const.dart';
import '../models.dart';
import '../niveles.dart';
import '../objetos/pixel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool isJuegoStart = false;
int? uNivel = 1;
//======================================================================
var nivelLActual = 1;
//======================================================================

void getNivel() async {
  final prefs = await SharedPreferences.getInstance();
  uNivel = prefs.getInt('uNivel') ?? 1;
}

void setNivel() async {
  final prefs = await SharedPreferences.getInstance();
  if (uNivel! <= nivelLActual + 1) {
    await prefs.setInt('uNivel', nivelLActual);
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int numPixeles = numFilas * numColumnas;
  int jugador = 130;
  int monedasR = 0;
  int posEnemigo = 130;

  String direccioMov = "";
  var cont = 0;
  var vidas = kVidas;

  var antiMonedas = [];

  var nivel = Niveles.fromJson(nivelA);

  void initJuego() {
    //movimiento enemigo
    Timer.periodic(const Duration(milliseconds: 240), (timer) {
      setState(() {
        posEnemigo = nivel.enemigo[cont];
      });
      cont++;
      if (cont >= nivel.enemigo.length) {
        cont = 0;
      }

      derrotado();
      //se matan al jugador se para el juego y el enemigo
      if (isJuegoStart == false) {
        timer.cancel();
      }
    });
  }

  void load() {
    switch (nivelLActual) {
      case 1:
        {
          nivelA = nivelN1;
          break;
        }
      case 2:
        {
          nivelA = nivelN2;
          break;
        }
      case 3:
        {
          nivelA = nivelN3;
          break;
        }
      case 4:
        {
          nivelA = nivelN4;
          break;
        }
      case 5:
        {
          nivelA = nivelN5;
          break;
        }
      case 6:
        {
          nivelA = nivelN6;
          break;
        }
      case 7:
        {
          nivelA = nivelN7;
          break;
        }
      case 8:
        {
          nivelA = nivelN8;
          break;
        }
      case 9:
        {
          nivelA = nivelN9;
          break;
        }
      case 10:
        {
          nivelA = nivelN10;
          break;
        }
      case 11:
        {
          nivelA = nivelN11;
          break;
        }
      case 12:
        {
          nivelA = nivelN12;
          break;
        }
      case 13:
        {
          nivelA = nivelN13;
          break;
        }
      case 14:
        {
          nivelA = nivelN14;
          break;
        }
    }
    nivel = Niveles.fromJson(nivelA);

    setState(() {
      nivelA;
      jugador = jugadorPosOrigen;
      cont = 0;
    });
  }

  void startJuego(int vPos) {
    if (isJuegoStart == false) {
      load();
      initJuego();

      isJuegoStart = true;
    }

    switch (vPos) {
      //arriba
      case 0:
        {
          accionxPos(jugador - numFilas);
        }
        break;
      //izquierda
      case 1:
        {
          accionxPos(jugador - 1);
        }
        break;
      //derecha
      case 2:
        {
          accionxPos(jugador + 1);
        }
        break;
      //abajo
      case 3:
        {
          accionxPos(jugador + numFilas);
        }
    }
    print("antimonedas: $antiMonedas");
    print("nivel monedas: ${nivel.monedas})");

    derrotado();

    if (jugador == nivel.meta) {
      meta();
    }
  }

  //cuando el enemigo mata al jugador
  void derrotado() {
    if (jugador == posEnemigo) {
      isJuegoStart = false;
      vidas--;
      load();
      if (vidas == 0) {
        isJuegoStart == false;
        setState(() {
          nivelLActual = 1;
          uNivel = 1;
          vidas = kVidas;
        });
        setNivel();
        load();
      }

      //antimonedas lo que hace es almacenar las monedas recolectadas, para volverlas a colocar al reaparecer por muerte
      for (var element in antiMonedas) {
        nivel.monedas.add(element);
      }
      setState(() {
        antiMonedas.clear();
        monedasR = 0;
      });
    }
  }

  void meta() {
    if (monedasR == 4) {
      for (var element in antiMonedas) {
        nivel.monedas.add(element);
      }
      antiMonedas.clear();

      nivelLActual++;
      //cargar siguiente nivel
      load();
      //resetear monedas
      monedasR = 0;
      getNivel();
      setNivel();
    }
  }

  //acciones que se van a realizar para cada movimiento
  void accionxPos(aPos) {
    if (nivel.monedas.contains(aPos)) {
      monedasR++;
      antiMonedas.add(aPos);
      nivel.monedas.remove(aPos);
    }
    if (!nivel.barreras.contains(aPos)) {
      setState(() {
        jugador = aPos;
      });
    }
  }

  //==============================================================================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(children: [
        //tamaño zona de juego
        SizedBox(
          width: MediaQuery.of(context).size.width,
          //altura+ diferencia pixeles por arriba
          height: (MediaQuery.of(context).size.width / 10 * 13) + 50,
          child: GestureDetector(
            onTapDown: (details) {
              if (isJuegoStart == false) {
                load();
                initJuego();

                isJuegoStart = true;
              }
              var altura = 585 - 50;
              //arriba
              if (1.3 * details.globalPosition.dx + 50 >
                      details.globalPosition.dy &&
                  -1.3 * details.globalPosition.dx + altura >
                      details.globalPosition.dy) {
                accionxPos(jugador - numFilas);
              } //abajo
              else if (1.3 * details.globalPosition.dx + 50 <
                      details.globalPosition.dy &&
                  -1.3 * details.globalPosition.dx + altura <
                      details.globalPosition.dy) {
                accionxPos(jugador + numFilas);
              } //derecha
              else if (1.3 * details.globalPosition.dx + 50 >
                      details.globalPosition.dy &&
                  -1.3 * details.globalPosition.dx + altura <
                      details.globalPosition.dy) {
                accionxPos(jugador + 1);
              } //izquierda
              else if (1.3 * details.globalPosition.dx + 50 <
                      details.globalPosition.dy &&
                  -1.3 * details.globalPosition.dx + altura >
                      details.globalPosition.dy) {
                accionxPos(jugador - 1);
              }
              derrotado();

              if (jugador == nivel.meta) {
                meta();
              }
            },
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: numPixeles,
              itemBuilder: (BuildContext context, int index) {
                //==============================================
                //==============================================

                //var indexString = index.toString();
                var indexString = "";

                //==============================================
                //==============================================
                if (jugador == index) {
                  return (Jugador(
                      vColor: Colors.orange,
                      vChild: Text(indexString,
                          style: const TextStyle(color: Colors.white))));
                } else if (posEnemigo == index) {
                  return Enemigo(
                      vColor: Colors.red,
                      vChild: Text(indexString,
                          style: const TextStyle(color: Colors.white)));
                } else if (nivel.barreras.contains(index)) {
                  return Pixel(
                      vColor: Colors.blue,
                      vChild: Text(indexString,
                          style: const TextStyle(color: Colors.white)));
                } else if (nivel.monedas.contains(index)) {
                  return Moneda(
                      vColor: Colors.yellow,
                      vChild: Text(indexString,
                          style: const TextStyle(color: Colors.white)));
                } else if (nivel.meta == index) {
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
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              flex: 5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
                      flex: 1,
                      child: SizedBox(
                        width: 20,
                      )),
                  Flexible(
                    flex: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        const SizedBox(
                          height: 5,
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
                              width: 100,
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
                        const SizedBox(
                          height: 5,
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
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            children: [
                              const SizedBox(height: kFSize * 2),
                              IconButton(
                                icon: const Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                  size: kFSize + 10,
                                ),
                                onPressed: () {
                                  getNivel();
                                  setNivel();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SeleccionarNivel()));
                                },
                              ),
                              PopupMenuButton(
                                icon: const Icon(
                                  Icons.more_horiz_rounded,
                                  color: Colors.white,
                                ),
                                onSelected: (valor) {
                                  if (valor == 0) {
                                    setState(() {
                                      nivelLActual = 1;
                                      uNivel = 1;
                                    });
                                    monedasR = 0;
                                    setNivel();
                                    load();
                                  } else if (valor == 1) {
                                    load();
                                    monedasR = 0;
                                    //antimonedas lo que hace es almacenar las monedas recolectadas, para volverlas a colocar al reaparecer por muerte
                                    for (var element in antiMonedas) {
                                      nivel.monedas.add(element);
                                    }
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 0,
                                    child: Text("Reiniciar todos los niveles"),
                                  ),
                                  const PopupMenuItem(
                                    value: 1,
                                    child: Text("Reiniciar este nivel"),
                                  ),
                                ],
                              ),
                            ],
                          ))),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                  color: Colors.blue,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(kPaddingText / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Nivel $nivelLActual",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: kFSize - 2),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(
                        Icons.circle,
                        color: Colors.yellow,
                        size: kFSize - 1,
                        shadows: [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 10,
                              spreadRadius: 3)
                        ],
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Monedas: ${monedasR.toString()}",
                        style: const TextStyle(
                            color: Colors.white, fontSize: kFSize - 2),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Image.asset(
                        "assets/img/icono_vidas.png",
                        width: kFSize,
                        height: kFSize,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        "Vidas: ${vidas.toString()}",
                        style: const TextStyle(
                            color: Colors.white, fontSize: kFSize - 2),
                      ),
                    ],
                  )),
            )
          ],
        )),
      ]),
    );
  }
}
