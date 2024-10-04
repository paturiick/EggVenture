import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/strings.dart';

class ShopInfo {
  final String shopName, shopEmail, address;
  final int shopPhoneNumber;

  ShopInfo(
      {required this.shopName,
      required this.shopEmail,
      required this.address,
      required this.shopPhoneNumber});

  factory ShopInfo.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return ShopInfo(
        shopName: data[StringConstants.SHOPNAME],
        shopEmail: data[StringConstants.SHOPEMAIL],
        address: data[StringConstants.ADDRESS],
        shopPhoneNumber: data[StringConstants.SHOPPHONENUMBER]);
  }
}
