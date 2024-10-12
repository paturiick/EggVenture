import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final dbFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<DocumentReference> _addToCollection(String collectionName, Map<String, dynamic> data) async{
    return await dbFirestore.collection(collectionName).add(data);
  }

  Future<DocumentSnapshot> _get(String collectionName, String userId) async {
      return await dbFirestore.collection(collectionName).doc(userId).get();
  }


  Future<void> submitBusiness(
    String shopName, 
    String shopEmail,
    String shopAddress, 
    String shopPhoneNumber) async {
    try {
      _addToCollection('businessDetails', {
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

  Future<Map<String, dynamic>?> getUserName() async {
      try {
        final uid = getCurrentUserId();
        final userDetails = await _get('userDetails', uid);

        return userDetails.data() as Map<String, dynamic>;
      } catch (e) {
        print('$e');
        return null;
      }
    }

  String getCurrentUserId(){
    User? user = _auth.currentUser;
    return user?.uid ?? '';
  }
}
