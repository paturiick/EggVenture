import 'package:eggventure/widgets/navigation_bar_farmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:eggventure/routes/routes.dart';

class AddProductScreenFarmer extends StatefulWidget{
 @override 
 _AddProductScreenFarmerState createState() => _AddProductScreenFarmerState();
}

class _AddProductScreenFarmerState extends State<AddProductScreenFarmer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

   @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Add Product',
              style: TextStyle(
                fontFamily: 'AvenirNextCyr',
                fontWeight: FontWeight.bold,
                fontSize: 30,
                height: 1.2,
                color: Color(0xFF353E55),
              ),
            ),
            SizedBox(height: 5),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              decoration: BoxDecoration(
                color: Color(0xFF353E55),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 3, // Corrected typo here
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: NavigationBarWidgetFarmer(currentIndex: 0),
    );
  }
}