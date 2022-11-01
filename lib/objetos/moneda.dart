import 'package:flutter/material.dart';
import 'package:platjoc/const.dart';

class Moneda extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final vColor;
  // ignore: prefer_typing_uninitialized_variables
  final vChild;

  const Moneda({super.key, this.vColor, this.vChild});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(kPadding + 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            color: vColor,
            child: Center(child: vChild),
          ),
        ));
  }
}
