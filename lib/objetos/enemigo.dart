import 'package:flutter/material.dart';
import 'package:platjoc/const.dart';

class Enemigo extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final vColor;
  // ignore: prefer_typing_uninitialized_variables
  final vChild;

  const Enemigo({super.key, this.vColor, this.vChild});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(kPadding),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: vColor,
            child: const Center(child: Text("-_-")),
          ),
        ));
  }
}
