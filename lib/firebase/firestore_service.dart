import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final dbFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _addToCollection(String collectionName, String uid, Map<String, dynamic> data) async{
    return await dbFirestore.collection(collectionName).doc(uid).set(data);
  }

  Future<QuerySnapshot> _get(String collectionName) async{
    return await dbFirestore.collection(collectionName).get();
  }

  Future<DocumentSnapshot> getBasedOnId(String collectionName, String userId) async {
      return await dbFirestore.collection(collectionName).doc(userId).get();
  }


  Future<void> submitBusiness(
    String shopName, 
    String shopEmail,
    String shopAddress, 
    String shopPhoneNumber) async {
    try {

      final uid = getCurrentUserId();
      _addToCollection('businessDetails', uid, {
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

  String getCurrentUserId(){
    User? user = _auth.currentUser;
    return user?.uid ?? '';
  }
}
