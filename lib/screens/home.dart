import 'dart:async';

import 'package:flutter/material.dart';
import 'package:platjoc/objetos/enemigo.dart';
import 'package:platjoc/objetos/jugador.dart';
import 'package:platjoc/objetos/meta.dart';
import 'package:platjoc/objetos/moneda.dart';
import 'package:platjoc/screens/seleccionarnivel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const.dart';
import '../models.dart';
import '../niveles.dart';
import '../objetos/pixel.dart';
import '../providers/nivelinfo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool isJuegoStart = false;
int? uNivel = 0;

//======================================================================
var nivelLActual = 18;
//======================================================================

@override
void initState() {
  getNivel();
}

void getNivel() async {
  final prefs = await SharedPreferences.getInstance();
  uNivel = prefs.getInt('uNivel') ?? 0;
}

void setNivel() async {
  final prefs = await SharedPreferences.getInstance();
  if (uNivel! <= nivelLActual) {
    await prefs.setInt('uNivel', nivelLActual);
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int numPixeles = numFilas * numColumnas;
  int jugador = noPos;
  int monedasR = 0;
  int posEnemigo = noPos;
  int posEnemigo2 = noPos;

  var contEnemigo = 0;
  var contEnemigo2 = 0;
  var muertes = 0;

  var antiMonedas = [];

  //establece el nivel actual
  var nivel = Niveles.fromJson(nivelA);

  void initJuego() {
    //movimiento enemigo
    Timer.periodic(const Duration(milliseconds: eTime), (timer) {
      //estado enemigo
      setState(() {
        posEnemigo = nivel.enemigo[contEnemigo];
      });
      contEnemigo++;
      if (contEnemigo >= nivel.enemigo.length) {
        contEnemigo = 0;
      }

      //estado enemigo2
      if (nivel.enemigo2.isNotEmpty) {
        setState(() {
          posEnemigo2 = nivel.enemigo2[contEnemigo2];
        });
        contEnemigo2++;
        if (contEnemigo2 >= nivel.enemigo2.length) {
          contEnemigo2 = 0;
        }
      }

      derrotado();
      //si se muere el jugador, se para el juego y el enemigo
      if (isJuegoStart == false) {
        timer.cancel();
      }
    });
  }

  void load() {
    switch (nivelLActual) {
      case 0:
        {
          nivelA = nivelN0;
          break;
        }
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
      case 15:
        {
          nivelA = nivelN15;
          break;
        }
      case 16:
        {
          nivelA = nivelN16;
          break;
        }
      case 17:
        {
          nivelA = nivelN17;
          break;
        }
      case 18:
        {
          nivelA = nivelN18;
          break;
        }
      case 19:
        {
          nivelA = nivelN14;
          break;
        }
      case 20:
        {
          nivelA = nivelN14;
          break;
        }
    }
    nivel = Niveles.fromJson(nivelA);

    setState(() {
      nivelA;
      jugador = jugadorPosOrigen;

      contEnemigo = 0;
      contEnemigo2 = 0;

      posEnemigo = noPos;
      posEnemigo2 = noPos;
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

    derrotado();

    if (jugador == nivel.meta) {
      alLlegarMeta();
    }
  }

  //cuando el enemigo mata al jugador
  void derrotado() {
    if (jugador == posEnemigo || jugador == posEnemigo2) {
      isJuegoStart = false;
      muertes++;

      //antimonedas lo que hace es almacenar las monedas recolectadas, para volverlas a colocar al reaparecer por muerte
      for (var element in antiMonedas) {
        nivel.monedas.add(element);
      }
      antiMonedas.clear();
      setState(() {
        monedasR = 0;
      });
      load();
    }
  }

  void alLlegarMeta() {
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

  //============================================================================

  @override
  Widget build(BuildContext context) {
    final nivelInfo = Provider.of<NivelInfo>(context);

    final anchuraCanvas = MediaQuery.of(context).size.width;
    final alturaCanvas =
        MediaQuery.of(context).size.width / numFilas * numColumnas;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(children: [
        //zona de juego
        SizedBox(
          width: anchuraCanvas,
          //altura+ diferencia pixeles por arriba
          height: alturaCanvas + 50,
          child: GestureDetector(
              onTapDown: (details) {
                if (isJuegoStart == false) {
                  load();
                  initJuego();

                  isJuegoStart = true;
                }

                //arriba
                if (1.3 * details.globalPosition.dx + 50 >
                        details.globalPosition.dy &&
                    -1.3 * details.globalPosition.dx + alturaCanvas >
                        details.globalPosition.dy) {
                  accionxPos(jugador - numFilas);
                } //abajo
                else if (1.3 * details.globalPosition.dx + 50 <
                        details.globalPosition.dy &&
                    -1.3 * details.globalPosition.dx + alturaCanvas <
                        details.globalPosition.dy) {
                  accionxPos(jugador + numFilas);
                } //derecha
                else if (1.3 * details.globalPosition.dx + 50 >
                        details.globalPosition.dy &&
                    -1.3 * details.globalPosition.dx + alturaCanvas <
                        details.globalPosition.dy) {
                  accionxPos(jugador + 1);
                } //izquierda
                else if (1.3 * details.globalPosition.dx + 50 <
                        details.globalPosition.dy &&
                    -1.3 * details.globalPosition.dx + alturaCanvas >
                        details.globalPosition.dy) {
                  accionxPos(jugador - 1);
                }

                derrotado();

                if (jugador == nivel.meta) {
                  alLlegarMeta();
                }
              },

              //ZONA DE JUEGO=============================================================================================================================
              child: isJuegoStart
                  ? GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: numPixeles,
                      itemBuilder: (BuildContext context, int index) {
                        //==============================================
                        //==============================================

                        var indexString = index.toString();
                        //var indexString = "";

                        //==============================================
                        //==============================================

                        //nivel tutorial
                        if (nivelLActual == 0 && isJuegoStart == true) {
                          if (index == 15) {
                            indexString = "Cubi";
                          }
                          if (index == 45) {
                            indexString = "Etsi";
                          }
                        }

                        //pintar píxeles
                        if (jugador == index) {
                          return (Jugador(
                              vColor: Colors.orange,
                              vChild: Text(indexString,
                                  style:
                                      const TextStyle(color: Colors.white))));
                        } else if (posEnemigo == index ||
                            posEnemigo2 == index) {
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
                                  style:
                                      const TextStyle(color: Colors.white))));
                        }
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: numFilas),
                    )
                  //si el juego está parado:
                  : Container(
                      color: Colors.blue,
                      width: anchuraCanvas,
                      height: alturaCanvas + 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            nivelLActual == 0
                                ? "Tutorial"
                                : "Nivel $nivelLActual",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 50),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            "Pulsa en la pantalla para jugar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )),
        ),
        //zona de controles e información
        Expanded(
            //botones
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
                  //vacío a la izquierda
                  const Flexible(
                      flex: 1,
                      child: SizedBox(
                        width: 20,
                      )),
                  //botones control juego
                  Flexible(
                    flex: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //botón arriba
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
                            //botón izquierda
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
                            //botón derecha
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
                        //botón abajo
                        ElevatedButton(
                          onPressed: () {
                            startJuego(3);
                          },
                          child: const Icon(
                            Icons.arrow_drop_down,
                            size: kBtnSize,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  //botones niveles y reiniciar
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
                                  for (var element in antiMonedas) {
                                    nivel.monedas.add(element);
                                  }
                                  antiMonedas.clear();
                                  monedasR = 0;
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
                                    dialogoReiniciar();
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
            //información partida
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
                        "Muertes: ${muertes.toString()}",
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

  dialogoReiniciar() {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Reiniciar todos los niveles'),
              content: const Text(
                  '¿Seguro que quieres reiniciar todos los niveles?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                    setState(() {
                      nivelLActual = 1;
                      uNivel = 1;
                      muertes = 0;
                    });
                    monedasR = 0;
                    setNivel();
                    load();
                  },
                  child: const Text('Sí'),
                ),
              ],
            ));
  }
}
