import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platjoc/bloc/infomuertes_bloc.dart';
import 'package:platjoc/bloc/infonivel_bloc.dart';
import 'package:platjoc/bloc/puntuacion_bloc.dart';
import 'package:platjoc/screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const Cubets());
  });
}

class Cubets extends StatelessWidget {
  const Cubets({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => InfoMuertesBloc(),
        ),
        BlocProvider(
          create: (_) => InfoNivelBloc(),
        ),
        BlocProvider(
          create: (_) => InfoPuntuacionBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cubets',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
