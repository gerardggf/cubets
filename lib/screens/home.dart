import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platjoc/bloc/infomuertes_bloc.dart';
import 'package:platjoc/bloc/infomuertes_event.dart';
import 'package:platjoc/bloc/infonivel_bloc.dart';
import 'package:platjoc/bloc/infonivel_event.dart';
import 'package:platjoc/bloc/puntuacion_bloc.dart';
import 'package:platjoc/bloc/puntuacion_event.dart';
import 'package:platjoc/objetos/enemigo.dart';
import 'package:platjoc/objetos/jugador.dart';
import 'package:platjoc/objetos/meta.dart';
import 'package:platjoc/objetos/moneda.dart';
import 'package:platjoc/screens/gameover.dart';
import 'package:platjoc/screens/informacion.dart';
import 'package:platjoc/screens/seleccionarnivel.dart';

import '../const.dart';
import '../models.dart';
import '../objetos/pixel.dart';
import 'finjuego.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool isJuegoStart = false;
var nivelLActual = 0;

//main class--------------------------------------------------------------
class _HomeScreenState extends State<HomeScreen> {
  final audioPlayer = AudioPlayer();

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void sonidosPlay(url) async {
    await audioPlayer.play(AssetSource(url));
    Timer(const Duration(milliseconds: 800), () {
      audioPlayer.pause();
    });
  }

  static const double widthBtn = 95;
  static const double heightBtn = 60;

  int numPixeles = numFilas * numColumnas;
  int jugador = noPos;
  int monedasR = 0;
  int posEnemigo = noPos;
  int posEnemigo2 = noPos;

  var contEnemigo = 0;
  var contEnemigo2 = 0;

  var antiMonedas = [];

  //establece el nivel actual
  var nivel = Niveles.fromJson(nivelA);

  @override
  void initState() {
    context.read<InfoNivelBloc>().add(Actualizar());
    context.read<InfoNivelBloc>().state;
    context.read<InfoPuntuacionBloc>().state;
    super.initState();
  }

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

  void loadNivel() {
    mappearNiveles();
    nivel = Niveles.fromJson(nivelA);
    resetObjetosNivel();
  }

  void startJuego(int vPos) {
    if (isJuegoStart == false) {
      loadNivel();
      initJuego();

      isJuegoStart = true;
    } else {
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
      alLlegarMeta();
    }
  }

  //cuando el enemigo mata al jugador
  void derrotado() {
    if (jugador == posEnemigo || jugador == posEnemigo2) {
      sonidosPlay("audio/derrotado.wav");

      //antimonedas lo que hace es almacenar las monedas recolectadas, para volverlas a colocar al reaparecer por muerte
      resetMonedas();
      monedasR = 0;
      context.read<InfoMuertesBloc>().add(MasUno());
      loadNivel();
    }
    if (context.read<InfoMuertesBloc>().state >= vidas) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const GameOverScreen()));
      reiniciarNiveles();
    }
  }

  void alLlegarMeta() {
    if (monedasR == 4 && jugador == nivel.meta) {
      if (nivelLActual == (totalNivelesD)) {
        context.read<InfoPuntuacionBloc>().add(Sumar());
        isJuegoStart = false;
        nivelLActual++;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const FinJuegoScreen()));
      } else {
        sonidosPlay("audio/siguienteNivel.wav");
        resetMonedas();
        context.read<InfoPuntuacionBloc>().add(Sumar());

        nivelLActual++;
        //cargar siguiente nivel
        loadNivel();
        //resetear monedas
        monedasR = 0;
        context.read<InfoNivelBloc>().add(Actualizar());
      }
    }
  }

  //acciones que se van a realizar para cada movimiento
  void accionxPos(aPos) {
    if (nivel.monedas.contains(aPos)) {
      sonidosPlay("audio/cogerMoneda.mp3");
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

  void resetObjetosNivel() {
    setState(() {
      nivelA;
      jugador = jugadorPosOrigen;

      contEnemigo = 0;
      contEnemigo2 = 0;

      posEnemigo = noPos;
      posEnemigo2 = noPos;
    });
  }

  void resetMonedas() {
    for (var element in antiMonedas) {
      nivel.monedas.add(element);
    }
    antiMonedas.clear();
  }

  //============================================================================

  @override
  Widget build(BuildContext context) {
    final anchuraCanvas = MediaQuery.of(context).size.width;
    final alturaCanvas =
        MediaQuery.of(context).size.width / numFilas * numColumnas;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: BlocBuilder<InfoMuertesBloc, int>(
        builder: (context, muertes) => Column(children: [
          //zona de juego
          SizedBox(
            width: anchuraCanvas,
            //altura+ diferencia pixeles por arriba
            height: alturaCanvas + 50,
            child: GestureDetector(
                onTapDown: (details) {
                  if (isJuegoStart == false) {
                    loadNivel();
                    initJuego();

                    isJuegoStart = true;
                  } else {
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
                    alLlegarMeta();
                  }
                },

                //ZONA DE JUEGO================
                child: isJuegoStart
                    ? GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: numPixeles,
                        itemBuilder: (BuildContext context, int index) {
                          var indexString = "";
                          cuadriculaNums == true
                              ? indexString = index.toString()
                              : indexString = "";

                          //nivel tutorial
                          if (nivelLActual == 0 && isJuegoStart == true) {
                            if (index == 15 || index == 45) {
                              indexString = "✖";
                            }
                            if (index == 41 ||
                                index == 71 ||
                                index == 103 ||
                                index == 106) {
                              indexString = "✔";
                            }
                            if (index == 21) {
                              indexString = "${monedasR.toString()}/4";
                            }
                          }

                          //pintar píxeles
                          if (jugador == index) {
                            return Jugador(
                                vColor: Colors.orange,
                                vChild: Text(indexString,
                                    style:
                                        const TextStyle(color: Colors.white)));
                          } else if (posEnemigo == index ||
                              posEnemigo2 == index) {
                            return Enemigo(
                                vColor: Colors.red,
                                vChild: Text(indexString,
                                    style:
                                        const TextStyle(color: Colors.white)));
                          } else if (nivel.barreras.contains(index) &&
                                  nivel.enemigo.contains(index) ||
                              nivel.barreras.contains(index) &&
                                  nivel.enemigo2.contains(index)) {
                            return Pixel(
                                vColor: kColor.withOpacity(0.5),
                                vChild: Text(indexString,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 10)));
                          } else if (nivel.barreras.contains(index)) {
                            return Pixel(
                                vColor: kColor,
                                vChild: Text(indexString,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 10)));
                          } else if (nivel.monedas.contains(index)) {
                            return Moneda(
                                vColor: Colors.yellow,
                                vChild: Text(indexString,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 10)));
                          } else if (nivel.meta == index) {
                            return Meta(
                                vColor: Colors.white,
                                vChild: Text(indexString,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 10)));
                          } else {
                            return (Pixel(
                                vColor: kBackgroundColor,
                                vChild: Text(indexString,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14))));
                          }
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: numFilas),
                      )
                    //si el juego está parado:
                    : Container(
                        color: kColor,
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: kPaddingText + 10,
                                  right: kPaddingText + 10),
                              child: Text(
                                nivelLActual == 0
                                    ? 'Pulsa en la pantalla para jugar. Puedes ver las instrucciones y más información acerca del juego pulsando el icono de la "i" rodeada por un círculo, situado a la derecha de los controles.'
                                    : 'Pulsa en la pantalla para jugar',
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white),
                              ),
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
                          GestureDetector(
                            onTap: () => startJuego(0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kColor,
                                  borderRadius: BorderRadius.circular(10)),
                              width: widthBtn,
                              height: heightBtn,
                              child: const Icon(
                                Icons.arrow_drop_up,
                                size: kBtnSize,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => startJuego(1),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: kColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: widthBtn,
                                  height: heightBtn,
                                  child: const Icon(
                                    Icons.arrow_left,
                                    size: kBtnSize,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: widthBtn + 5,
                              ),
                              GestureDetector(
                                onTap: () => startJuego(2),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: kColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: widthBtn,
                                  height: heightBtn,
                                  child: const Icon(
                                    Icons.arrow_right,
                                    size: kBtnSize,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => startJuego(3),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kColor,
                                  borderRadius: BorderRadius.circular(10)),
                              width: widthBtn,
                              height: heightBtn,
                              child: const Icon(
                                Icons.arrow_drop_down,
                                size: kBtnSize,
                                color: Colors.white,
                              ),
                            ),
                          )
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
                                    resetMonedas();
                                    monedasR = 0;
                                    resetObjetosNivel();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SeleccionarNivel()));
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.info_outline_rounded,
                                    color: Colors.white,
                                    size: kFSize + 10,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const InformacionScreen()));
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
                                      loadNivel();
                                      monedasR = 0;

                                      //antimonedas lo que hace es almacenar las monedas recolectadas, para volverlas a colocar al reaparecer por muerte
                                      resetMonedas();
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 0,
                                      child:
                                          Text("Reiniciar todos los niveles"),
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
              //información de la partida
              Container(
                  color: kColor,
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
                        "${monedasR.toString()}/4",
                        style: const TextStyle(
                            color: Colors.white, fontSize: kFSize - 2),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Image.asset(
                        "assets/img/icono_cubets.png",
                        width: kFSize,
                        height: kFSize,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        "${vidas - muertes}",
                        style: const TextStyle(
                            color: Colors.white, fontSize: kFSize - 2),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(
                        Icons.point_of_sale,
                        color: Colors.white,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        context.read<InfoPuntuacionBloc>().state.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontSize: kFSize - 2),
                      ),
                    ],
                  )),
            ],
          )),
        ]),
      ),
    );
  }

  reiniciarNiveles() {
    setState(() {
      nivelLActual = 0;
      context.read<InfoNivelBloc>().add(ReiniciarUno());
      context.read<InfoMuertesBloc>().add(ReiniciarMuertes());
      context.read<InfoPuntuacionBloc>().add(ReiniciarPuntuacion());
    });
    resetMonedas();
    monedasR = 0;
    loadNivel();
    isJuegoStart = false;
  }

  dialogoReiniciar() {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Reiniciar todos los niveles'),
              content: const Text(
                  '¿Seguro que quieres reiniciar todos los niveles? Se va a borrar todos los niveles ya completados. Se te reiniciaran las vidas y la puntuación.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                    reiniciarNiveles();
                  },
                  child: const Text('Sí'),
                ),
              ],
            ));
  }
}
