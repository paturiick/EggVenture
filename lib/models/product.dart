import 'package:cloud_firestore/cloud_firestore.dart';

class Product {

  Product({required this.productName, required this.productDescription, required this.size, required this.eggType});

  final String productName;
  final String productDescription;
  final String size;
  final String eggType;

  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return Product(
      productName: data['productName'] ?? '',
      productDescription: data['productDescription'] ?? '',
      size: data['size'] ?? '',
      eggType: data['eggType'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'productDescription': productDescription,
      'size': size,
      'eggType': eggType  
    };
  }
}