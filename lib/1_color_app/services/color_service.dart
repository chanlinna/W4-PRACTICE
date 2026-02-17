import 'package:flutter/material.dart';
import 'package:w4_practice/1_color_app/color_app.dart';

class ColorService extends ChangeNotifier {
  final Map<CardType, int> _tapCounts = {};

  ColorService() {
    for (var type in CardType.values) {
      _tapCounts[type] = 0;
    }
  }

  Map<CardType, int> get tapCounts => _tapCounts;

  void incrementCount(CardType type) {
    _tapCounts[type] = _tapCounts[type]! + 1;
    notifyListeners();
  }
}
