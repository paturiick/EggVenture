import 'package:cloud_firestore/cloud_firestore.dart';

class OrderStatus {
  final int id;
  final String name, imagePath, screenId;
  int amount;
  double totalPrice;
  String status;

  OrderStatus(
      {required this.id,
      required this.name,
      required this.imagePath,
      required this.screenId,
      required this.amount,
      required this.totalPrice,
      this.status = 'Pending'});
}
