import 'package:eggventure/models/tray_item.dart';
import 'package:flutter/material.dart';

class BuyNowProvider extends ChangeNotifier {
  final List<TrayItem> buyItems = [];
  List<TrayItem> selectedItems = [];
  double _subtotal = 0.0;
  double get subtotal => _subtotal;

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
    _recalculateSubtotal(); // Recalculate subtotal after removal
    notifyListeners();
  }

  void clearTray() {
    selectedItems.clear();
    buyItems.clear();
    _subtotal = 0.0; // Reset subtotal
    notifyListeners();
  }

  void incrementAmount(int index) {
    buyItems[index].amount += 1;
    _recalculateSubtotal(); // Recalculate subtotal after increment
    notifyListeners();
  }

  void decrementAmount(int index) {
    if (buyItems[index].amount > 0) {
      buyItems[index].amount--;
      _recalculateSubtotal(); // Recalculate subtotal after decrement
    }
    notifyListeners();
  }

  int calculateTotalPrice(TrayItem item) {
    return item.price * item.amount;
  }

  // Calculate the subtotal of all items
  void _recalculateSubtotal() {
    double sum = 0.0;
    for (var item in buyItems) {
      sum += item.amount * item.price; // Multiply amount by price
    }
    _subtotal = sum; // Update the subtotal
  }

  void addToTray(TrayItem item) {
    // Check if the item already exists in the tray
    final existingItemIndex =
        buyItems.indexWhere((trayItem) => trayItem.id == item.id);

    if (existingItemIndex != -1) {
      // If the item exists, increment its amount
      buyItems[existingItemIndex].amount += 1;
    } else {
      // If the item does not exist, add it to the tray
      buyItems.add(item);
    }

    // Recalculate subtotal
    _recalculateSubtotal();
    notifyListeners();
  }
}
