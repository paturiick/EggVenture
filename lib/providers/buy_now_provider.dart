import 'package:eggventure/models/tray_item.dart';
import 'package:flutter/material.dart';

class BuyNowProvider extends ChangeNotifier {
  final List<TrayItem> buyItems = [];
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
    buyItems.remove(item);
    notifyListeners();
  }

  void clearTray() {
    buyItems.clear();
    notifyListeners();
  }

  void incrementAmount(int index) {
    buyItems[index].amount += 1;
    notifyListeners();
  }

  void decrementAmount(int index) {
    if (buyItems[index].amount > 0) {
      buyItems[index].amount--;
    }
    notifyListeners();
  }

    int calculateTotalPrice(TrayItem item) {
    return item.price * item.amount;
  }

  // Calculate the subtotal of all items
  double get subtotal {
    double sum = 0.0;
    for (var item in buyItems) {
      sum += calculateTotalPrice(item);
    }
    return sum;
  }
}
