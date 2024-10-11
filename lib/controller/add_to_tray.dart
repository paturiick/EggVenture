import 'package:flutter/material.dart';

class AddToTrayProvider extends ChangeNotifier{
  final List<Product> _cart = [];
  List <Product> get cart = _cart;
}