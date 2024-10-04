import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/strings.dart';

class FirestoreService {
  final dbFirestore = FirebaseFirestore.instance;

  Future<void> submitBusiness(String shopName, String shopEmail,
      String shopAddress, String shopPhoneNumber) async {
    try {
      await dbFirestore.collection('business').add({
        StringConstants.SHOPNAME: shopName,
        StringConstants.SHOPEMAIL: shopEmail,
        StringConstants.ADDRESS: shopAddress,
        StringConstants.SHOPPHONENUMBER: shopPhoneNumber
      });
    } catch (e) {
      print('Error submitting business: $e');
      return null;
    }
  }
}
