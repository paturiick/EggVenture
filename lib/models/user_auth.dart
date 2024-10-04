import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/strings.dart';

class UserAuthModel {
  
  UserAuthModel({
    required this.lastName, 
    required this.firstName, 
    required this.userPhoneNumber
  });

  final String lastName, firstName;
  final int userPhoneNumber;

  factory UserAuthModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return UserAuthModel(
        lastName: data[StringConstants.LASTNAME],
        firstName: data[StringConstants.FIRSTNAME],
        userPhoneNumber: data[StringConstants.USERPHONENUMBER]
    );
  }

  Map<String, dynamic> toMap() => {
    // e add ang appstrings parehas sa ubos
  };

  @override
  String toString() {
    return super.toString();
  }
}

// sample code
// guide rani unsaon pag gamit sa models
// appstrings kay constant na nga naa sa constants folder namo

// import 'package:app/utils/constants/strings.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class CarOwnerModel {

//   CarOwnerModel( { 
//     this.id,
//     this.uid,
//     this.firstname,
//     this.lastname,
//     this.username,
//     this.email,
//     this.phonenumer,
//   } );

//   final String? id, uid, 
//     firstname, lastname, username, email, phonenumer;

//   factory CarOwnerModel.fromSnapshot(DocumentSnapshot snapshot) {
//     final data = snapshot.data() as Map<String, dynamic>;
//     return CarOwnerModel(
//       id: snapshot.id.toString(),
//       uid: data[AppStrings.UID],
//       firstname: data[AppStrings.FIRSTNAME],
//       lastname: data[AppStrings.LASTNAME],
//       username: data[AppStrings.USERNAME],
//       email: data[AppStrings.EMAIL],
//       phonenumer: data[AppStrings.PHONENUMBER],
//     );
//   }

//   Map<String, dynamic> toMap() => {
//     AppStrings.UID: uid,
//     AppStrings.FIRSTNAME: firstname,
//     AppStrings.LASTNAME: lastname,
//     AppStrings.USERNAME: username,
//     AppStrings.EMAIL: email,
//     AppStrings.PHONENUMBER: phonenumer,
//   };

//   @override
//   String toString() {
//     return super.toString();
//   }
// }