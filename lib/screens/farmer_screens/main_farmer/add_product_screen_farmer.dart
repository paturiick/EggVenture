import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/controller/add_product_controller.dart';
import 'package:eggventure/widgets/navigation%20bars/navigation_bar_farmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddProductScreenFarmer extends StatefulWidget {
  @override
  _AddProductScreenFarmerState createState() => _AddProductScreenFarmerState();
}

class _AddProductScreenFarmerState extends State<AddProductScreenFarmer> {
  final AddProductControllers _controllers = AddProductControllers();

  @override
  void dispose() {
    _controllers.dispose(); // Dispose the controllers here
    super.dispose();
  }

  Widget _buildTextField(String label, TextEditingController controller, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }

  Widget _buildImagePicker(double screenWidth) {
    return Container(
      width: screenWidth * 0.3,
      height: screenWidth * 0.3,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Center(
        child: IconButton(
          icon: Icon(Icons.add, size: screenWidth * 0.08),
          onPressed: () {
            // Logic to add an image
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark
      )
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Add Product',
              style: TextStyle(
                fontFamily: 'AvenirNextCyr',
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.06, // Responsive font size
                color: AppColors.BLUE,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Container(
              width: screenWidth,
              height: screenHeight * 0.002,
              decoration: BoxDecoration(
                color: AppColors.BLUE,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.BLUE.withOpacity(0.2),
                    spreadRadius: screenWidth * 0.01,
                    blurRadius: screenWidth * 0.02,
                    offset: Offset(0, screenHeight * 0.005),
                  ),
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Basic Information',
                style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold, color: AppColors.BLUE),
              ),
              _buildTextField('Product Name', _controllers.productNameController, screenWidth),
              _buildTextField('Product Description', _controllers.productDescriptionController, screenWidth),
              _buildTextField('Size', _controllers.sizeController, screenWidth),
              _buildTextField('Egg Type', _controllers.eggTypeController, screenWidth),
              SizedBox(height: screenHeight * 0.03),
              Text(
                'Media Management',
                style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold, color: AppColors.BLUE),
              ),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                mainAxisSpacing: screenHeight * 0.015,
                crossAxisSpacing: screenWidth * 0.02,
                children: <Widget>[
                  _buildImagePicker(screenWidth),
                  _buildImagePicker(screenWidth),
                  _buildImagePicker(screenWidth),
                  _buildImagePicker(screenWidth),
                  _buildImagePicker(screenWidth),
                  _buildImagePicker(screenWidth),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Logic for Cancel
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(screenWidth * 0.4, screenHeight * 0.07),
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.015),
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.BLUE,
                          side: BorderSide(color: AppColors.YELLOW),
                        ),
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Logic for Save and Delist
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(screenWidth * 0.4, screenHeight * 0.07),
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.015),
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.BLUE,
                          side: BorderSide(color: AppColors.YELLOW),
                        ),
                        child: Text('Save and Delist'),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  ElevatedButton(
                    onPressed: () {
                      // Logic for Save and Publish
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(screenWidth * 0.4, screenHeight * 0.07),
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.015),
                      backgroundColor: AppColors.YELLOW,
                      foregroundColor: AppColors.BLUE,
                    ),
                    child: Text('Save and Publish'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBarWidgetFarmer(currentIndex: 2),
    );
  }
}
