import 'package:flutter/material.dart';
import 'package:platjoc/const.dart';
import 'package:platjoc/screens/seleccionarnivel.dart';

class InformacionScreen extends StatelessWidget {
  const InformacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: kColor, title: const Text("Información")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kPaddingText - 2),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(kPaddingText - 2),
              width: double.infinity,
              decoration: BoxDecoration(color: kColor.withOpacity(0.3)),
              child: Column(
                children: [
                  const Text("¿En qué consiste Cubets?",
                      style: TextStyle(
                          fontSize: kFSize + 8, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Ayuda a Cubets, un cuadrado naranja bastante apático que se ha visto atrapado en un juego para teléfonos móviles. \n\nPara poder escapar tiene que superar todos los niveles de este juego, subiendo de nivel mediante un portal de color blanco.",
                    style: TextStyle(fontSize: kFSize - 5),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    "assets/img/icono_cubets.png",
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Sin embargo, Cubets tiene que haber cogido todas las monedas de cada nivel para poder pasar por dicho portal.",
                    style: TextStyle(fontSize: kFSize - 5),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: const TextSpan(
                      text:
                          "En cada nivel, te vas a encontrar con uno o dos cuadrados rojos que van rondando por cada nivel ",
                      style: TextStyle(
                          fontSize: kFSize - 5, color: kBackgroundColor),
                      children: <TextSpan>[
                        TextSpan(
                            text: "siguiendo siempre el mismo recorrido",
                            style: TextStyle(fontWeight: FontWeight.w900)),
                        TextSpan(
                          text:
                              "\n\nVe con cuidado, ya que no te lo van a poner fácil. Pueden atravesar las paredes de color azul oscuro, cosa que tu no puedes hacer, y a medida que vayas avanzando te lo pondrán cada vez más difícil. Pueden incluso llegar a teletransportarse.",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Cubets tiene casi el triple de vidas que un gato, pero si las gasta todas, tendrá que volver a empezar de cero... Mucha suerte.",
                    style: TextStyle(fontSize: kFSize - 5),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: kPaddingText,
            ),
            Container(
              padding: const EdgeInsets.all(kPaddingText),
              width: double.infinity,
              decoration: BoxDecoration(color: kColor.withOpacity(0.3)),
              child: Column(
                children: [
                  const Text("¿Cómo se juega?",
                      style: TextStyle(
                          fontSize: kFSize + 8, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Puedes controlar a tu jugador mediante los botones de la parte inferior de la pantalla o bien tocando la propia zona de juego tal y como se muestra a continuación.",
                    style: TextStyle(fontSize: kFSize - 5),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Image.asset(
                    "assets/img/instruc_cubets.png",
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // Text(
                  //   "En la parte inferior de la pantalla verás varios indicadores con el siguiente orden de izquierda a derecha: \n- Nivel actual: Nivel por el que vas del total de los ${arrayNiveles.length - 1} que hay \n- Monedas recolectadas: Tienes que recoger las cuatro monedas de cada nivel para poder pasar al siguiente \n- Vidas restantes: Empiezas con $vidas vidas y al morir se te van restando.\n- Indicador de puntos: Ganarás más puntos como menos mueras y a medida que vayas pasando de nivel",
                  //   style: const TextStyle(fontSize: kFSize - 2),
                  // ),
                  RichText(
                    text: TextSpan(
                      text:
                          "En la parte inferior de la pantalla verás varios indicadores con el siguiente orden, de izquierda a derecha:\n",
                      style: const TextStyle(
                          fontSize: kFSize - 5, color: kBackgroundColor),
                      children: <TextSpan>[
                        const TextSpan(
                            text: "\n- Nivel actual:",
                            style: TextStyle(fontWeight: FontWeight.w900)),
                        TextSpan(
                          text:
                              " Nivel que estás jugando del total de los ${arrayNiveles.length - 1} que hay.",
                        ),
                        const TextSpan(
                            text: "\n- Monedas recolectadas:",
                            style: TextStyle(fontWeight: FontWeight.w900)),
                        const TextSpan(
                            text:
                                " Tienes que recoger las cuatro monedas de cada nivel para poder pasar al siguiente."),
                        const TextSpan(
                            text: "\n- Vidas restantes:",
                            style: TextStyle(fontWeight: FontWeight.w900)),
                        const TextSpan(
                          text:
                              " Empiezas con $vidas vidas y al morir se te van restando.",
                        ),
                        const TextSpan(
                            text: "\n- Indicador de puntos: ",
                            style: TextStyle(fontWeight: FontWeight.w900)),
                        const TextSpan(
                            text:
                                " Ganarás más puntos como menos mueras y a medida que vayas pasando de nivel."),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Image.asset(
                    "assets/img/barra_cubets.png",
                    height: 35,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "En la pantalla de juego pulsa el botón con tres líneas horizontales para ver el listado de niveles completados, mediante el cual podrás jugar a los niveles anteriormente superados.\n\nCuando las vidas lleguen a 0, tendrás que volver a empezar de nuevo todos los niveles, eliminándose así de la lista de niveles disponibles.\n\nConsigue llegar al último nivel muriendo el menor número de veces posibles para así terminar con una mayor cantidad de puntos.\n\nAdicionalmente, puedes reiniciar todos los niveles clicando al botón con tres puntos en la pantalla de juego, para poder reiniciar así los contadores.",
                    style: TextStyle(fontSize: kFSize - 5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
