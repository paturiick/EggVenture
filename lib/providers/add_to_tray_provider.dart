import 'package:eggventure/models/tray_item.dart';
import 'package:flutter/material.dart';

class AddToTrayProvider extends ChangeNotifier {
  final List<TrayItem> _trayItems = [];
  List<TrayItem> get trayItems => _trayItems;
   List<TrayItem> selectedItems = [];

  void toggleSelection(TrayItem item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
    notifyListeners();
  }

  

  void removeFromTray(TrayItem item) {
    _trayItems.remove(item);
    notifyListeners();
  }

  void clearTray() {
    _trayItems.clear();
    notifyListeners();
  }

  void incrementAmount(int index) {
    trayItems[index].amount += 1;
    notifyListeners();
  }

  void decrementAmount(int index) {
    if (trayItems[index].amount > 0) {
      trayItems[index].amount -= 1;
    }
    notifyListeners();
  }
}

