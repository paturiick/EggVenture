import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/strings.dart';

class ShopInfo {
  final String shopName, shopEmail, address;
  final int shopPhoneNumber;
  final String? profileImageUrl;

  ShopInfo({
    required this.shopName,
    required this.shopEmail,
    required this.address,
    required this.shopPhoneNumber,
    required this.profileImageUrl,
  });
  factory ShopInfo.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return ShopInfo(
      shopName: data[StringConstants.SHOPNAME] ?? '',
      shopEmail: data[StringConstants.SHOPEMAIL] ?? '',
      address: data[StringConstants.ADDRESS] ?? '',
      shopPhoneNumber: data[StringConstants.SHOPPHONENUMBER] ?? 0,
      profileImageUrl: data[StringConstants.PROFILEIMAGEURL] ?? null,
    );
  }

  // Method to convert ShopInfo instance to a map for saving to Firestore
  Map<String, dynamic> toMap() {
    return {
      StringConstants.SHOPNAME: shopName,
      StringConstants.SHOPEMAIL: shopEmail,
      StringConstants.ADDRESS: address,
      StringConstants.SHOPPHONENUMBER: shopPhoneNumber,
      StringConstants.PROFILEIMAGEURL: profileImageUrl ?? '',
    };
  }
}
