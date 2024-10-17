import 'package:flutter/material.dart';

class AddToTrayProvider extends ChangeNotifier {
  final List<String> _trayItems = [];
  List<String> get trayItems => _trayItems;

  void addToTray(String item) {
    _trayItems.add(item);
    notifyListeners();
  }

  void removeFromTray(String item) {
    _trayItems.remove(item);
    notifyListeners();
  }

  void clearTray(String item) {
    _trayItems.clear();
    notifyListeners();
  }
}
