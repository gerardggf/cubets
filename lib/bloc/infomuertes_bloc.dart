import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'infomuertes_event.dart';

class InfoMuertesBloc extends Bloc<InfoMuertesEvent, int> {
  InfoMuertesBloc() : super(0) {
    _getMuertes();
    on<MasUno>(_masUno);
    on<ReiniciarMuertes>(_reiniciar);
  }

  void _getMuertes() async {
    final prefs = await SharedPreferences.getInstance();
    // ignore: invalid_use_of_visible_for_testing_member
    emit(prefs.getInt('muertes') ?? 0);
  }

  void _masUno(InfoMuertesEvent event, Emitter<int> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final nMuertes = (prefs.getInt('muertes') ?? 0) + 1;
    emit(nMuertes);
    prefs.setInt('muertes', nMuertes);
  }

  void _reiniciar(InfoMuertesEvent event, Emitter<int> emit) async {
    final prefs = await SharedPreferences.getInstance();
    const nMuertes = 0;
    emit(nMuertes);
    prefs.setInt('muertes', nMuertes);
  }
}
