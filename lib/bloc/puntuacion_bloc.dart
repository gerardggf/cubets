import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platjoc/bloc/puntuacion_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoPuntuacionBloc extends Bloc<InfoPuntuacionEvent, int> {
  InfoPuntuacionBloc() : super(0) {
    _getPuntuacion();
    on<Sumar>(_sumar);
    on<Reiniciar>(_reiniciar);
  }

  void _getPuntuacion() async {
    final prefs = await SharedPreferences.getInstance();
    // ignore: invalid_use_of_visible_for_testing_member
    emit(prefs.getInt('puntuacion') ?? 0);
  }

  void _sumar(InfoPuntuacionEvent event, Emitter<int> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final nPuntuacion = (prefs.getInt('puntuacion') ?? 0) + 1;
    emit(nPuntuacion);
    prefs.setInt('puntuacion', nPuntuacion);
  }

  void _reiniciar(InfoPuntuacionEvent event, Emitter<int> emit) async {
    final prefs = await SharedPreferences.getInstance();
    const nPuntuacion = 0;
    emit(nPuntuacion);
    prefs.setInt('puntuacion', nPuntuacion);
  }
}
