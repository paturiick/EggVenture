import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/controller/add_product_controller.dart';
import 'package:eggventure/controller/image_picker_controller.dart';
import 'package:eggventure/models/product.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/widgets/image%20picker%20widget/image_picker_widget.dart';
import 'package:eggventure/widgets/navigation%20bars/navigation_bar_farmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/firebase/firebase auth/firestore_service.dart';

class AddProductScreenFarmer extends StatefulWidget {
  @override
  _AddProductScreenFarmerState createState() => _AddProductScreenFarmerState();
}

class _AddProductScreenFarmerState extends State<AddProductScreenFarmer> {
  final AddProductControllers _controllers = AddProductControllers();

  final ImagePickerController _imagePickerController = ImagePickerController();
  XFile? imageFile;

  final FirestoreService _firestoreService = FirestoreService();

  void imageSelection(ImageSource source) async{
    final XFile? pickedFile = await _imagePickerController.pickImage(source);
    setState(() {
      imageFile = pickedFile;
    });
  }

  @override
  void dispose() {
    _controllers.dispose(); // Dispose the controllers here
    super.dispose();
  }

  Widget _buildTextField(String label, TextEditingController controller, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: TextField(
        style: TextStyle(
          color: AppColors.BLUE
        ),
        cursorColor: AppColors.YELLOW,
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.YELLOW)
          ),
          border: OutlineInputBorder(),
          labelText: label,
          labelStyle: TextStyle(
            color: AppColors.BLUE
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.BLUE
            )
          )
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
          onPressed: () => ImagePickerWidget.showMenu(context),
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
        backgroundColor: Colors.white,
        elevation: 0, // Remove shadow
        centerTitle: true,
        //leading: IconButton(onPressed: (onPressed), icon: icon),
        title: Text(
          'Add Product',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.07, // Responsive font size
            color: AppColors.BLUE,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1), // Height of the bottom border
          child: Container(
            color: Colors.grey[300], // Bottom border color
            height: 1, // Border thickness
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Basic Information',
                style: TextStyle(fontSize: screenWidth * 0.05, 
                fontWeight: FontWeight.bold, 
                color: AppColors.BLUE),
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
                          Navigator.pop(context);
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
                    onPressed: () async {
                      final productNameString = _controllers.productNameController.text.trim(); 
                      final productDescriptionString = _controllers.productDescriptionController.text.trim();
                      final sizeString = _controllers.sizeController.text.trim();
                      final eggTypeString = _controllers.eggTypeController.text.trim();

                      final product = Product(
                        productName: productNameString,
                        productDescription: productDescriptionString,
                        size: sizeString,
                        eggType: eggTypeString,
                      );

                      await _firestoreService.addProduct(product.toMap());

                      Navigator.pushNamed(context, AppRoutes.HOMEFARMER);
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
