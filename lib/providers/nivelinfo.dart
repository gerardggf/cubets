import 'package:flutter/material.dart';

class NivelInfo with ChangeNotifier {
  var _monedasR = 0;

  get nivelActual {
    return _monedasR;
  }

  set monedasR(var monedasR) {
    _monedasR = monedasR;

    notifyListeners();
  }
}
