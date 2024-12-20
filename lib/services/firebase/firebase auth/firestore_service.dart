import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final dbFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _addToCollection(String collectionName, String uid, Map<String, dynamic> data) async{
    return await dbFirestore.collection(collectionName).doc(uid).set(data);
  }

  Future<void> _create(String collectionPath, Map<String, dynamic> data) async {
    await dbFirestore.collection(collectionPath).add(data);
  }

  Future<void> _createSubCollection(String collectionpath, String subCollectionPath, Map<String, dynamic> data, String uid) async {
    await dbFirestore.collection(collectionpath).doc(uid).collection(subCollectionPath).add(data);
  }

  Future<QuerySnapshot> _get(String collectionName) async{
    return await dbFirestore.collection(collectionName).get();
  }

  Future<DocumentSnapshot> getBasedOnId(String collectionName, String userId) async {
      return await dbFirestore.collection(collectionName).doc(userId).get();
  }

  Future<void> fetchUsers() async {
    try {
      
    } catch (e) {
      
    }
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
        StringConstants.SHOPPHONENUMBER: shopPhoneNumber,
        StringConstants.USERID: uid
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

  Future<void> updateUserField(
      String userId, String fieldName, dynamic value) async {
    try {
      await dbFirestore
          .collection('userDetails')
          .doc(userId)
          .update({fieldName: value});
    } catch (e) {
      print('Error updating user field: $e');
    }
  }

  Stream<DocumentSnapshot> getUserProfileStream(String userId) {
    return dbFirestore.collection('userDetails').doc(userId).snapshots();
  }

  Future<void> addProduct(Map<String, dynamic> data) async {
    final uid = getCurrentUserId();
    await _createSubCollection('businessDetails', 'products', data, uid);
  }

  Future<QuerySnapshot> getBusinessDetails() async {
    final businessDetails = await _get('businessDetails');
    return businessDetails;
  }

  Future<QuerySnapshot> getProducts(String uid) async {
    final docRef = await dbFirestore.collection('businessDetails').where('userId', isEqualTo: uid).get();
    final products = await docRef.docs.first.reference.collection('products').get();
    
    return products;
  }
  
  Future<List<String>> getEmails() async {
    List<String> emails = [];
    await dbFirestore.collection('userDetails').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        emails.add(doc['userEmail']);
      });
    });
    return emails;
  }

  Future<void> addTransaction(
    String userId,
    String total,
    Timestamp timestamp
  ) async {
    final data = {
      'userId': userId,
      'total': total,
      'timestamp': timestamp
    };

    await _create('transactions', data);
  }
}
