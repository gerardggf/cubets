import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platjoc/bloc/infonivel_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/home.dart';

class InfoNivelBloc extends Bloc<InfoNivelEvent, int> {
  InfoNivelBloc() : super(0) {
    _getNivel();
    on<Actualizar>(_actualizar);
    on<ReiniciarUno>(_reiniciarUno);
  }

  void _getNivel() async {
    final prefs = await SharedPreferences.getInstance();
    final uNivel = prefs.getInt('nivel') ?? 0;
    nivelLActual = uNivel;
    // ignore: invalid_use_of_visible_for_testing_member
    emit(uNivel);
  }

  void _actualizar(InfoNivelEvent event, Emitter<int> emit) async {
    final prefs = await SharedPreferences.getInstance();
    var uNivel = prefs.getInt('nivel') ?? 1;
    if (uNivel <= nivelLActual) {
      await prefs.setInt('nivel', nivelLActual);
      uNivel = nivelLActual;
    }
    emit(uNivel);
  }

  void _reiniciarUno(InfoNivelEvent event, Emitter<int> emit) async {
    final prefs = await SharedPreferences.getInstance();
    const uNivel = 1;
    emit(uNivel);
    prefs.setInt('nivel', uNivel);
  }
}
