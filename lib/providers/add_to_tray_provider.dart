import 'package:eggventure/models/tray_item.dart';
import 'package:flutter/material.dart';

class AddToTrayProvider extends ChangeNotifier {
  final List<TrayItem> _trayItems = [];
  List<TrayItem> get trayItems => _trayItems;

  void addToTray(TrayItem item) {
    _trayItems.add(item);
    print(_trayItems);
    notifyListeners();
  }

  void removeFromTray(TrayItem item) {
    _trayItems.remove(item);
    notifyListeners();
  }

  void clearTray(String item) {
    _trayItems.clear();
    notifyListeners();
  }
}
