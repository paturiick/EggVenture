import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/strings.dart';

class UserAuthModel {
  
  UserAuthModel({
    required this.lastName, 
    required this.firstName, 
    required this.userPhoneNumber,
    required this.userEmail,
    required this.isSeller
  });

  final String lastName, firstName, userEmail;
  final int userPhoneNumber;
  final bool isSeller;

  factory UserAuthModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return UserAuthModel(
        lastName: data[StringConstants.LASTNAME],
        firstName: data[StringConstants.FIRSTNAME],
        userPhoneNumber: data[StringConstants.USERPHONENUMBER],
        userEmail: data[StringConstants.USEREMAIL],
        isSeller: data[StringConstants.ISSELLER]
    );
  }

  Map<String, dynamic> toMap() => {
    StringConstants.FIRSTNAME: firstName,
    StringConstants.LASTNAME: lastName,
    StringConstants.USERPHONENUMBER: userPhoneNumber,
    StringConstants.USEREMAIL: userEmail,
    StringConstants.ISSELLER: isSeller
  };

  @override
  String toString() {
    return super.toString();
  }
}