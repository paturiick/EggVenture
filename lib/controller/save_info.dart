import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/models/shop_info.dart';
import 'package:flutter/material.dart';

class SaveInfo {
  Future<void> saveShopInfo(
      ShopInfo shopInfo, String shopInformationId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('shopInfo')
          .doc(shopInformationId)
          .set(shopInfo.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Shop information saved successfully!',
        style: TextStyle(
          color: AppColors.BLUE
        ),),
        backgroundColor: AppColors.YELLOW,),
      );
    } catch (e) {
      print("Failed to save Shop Information ${e}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save shop information.')),
      );
    }
  }
}
