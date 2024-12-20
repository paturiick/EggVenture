import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/controller/image_picker_controller.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget {
  static void showMenu(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final ImagePickerController _imagePickerController =
        ImagePickerController();
    XFile? imageFile;

    void imageSelection(ImageSource source) async {
      final XFile? pickedFile = await _imagePickerController.pickImage(source);
      setState(){
        imageFile = pickedFile;
      }
      
    }
    

    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white
          ),
          padding: EdgeInsets.all(5.0),
          height: 200,  
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () => imageSelection(ImageSource.camera),
                child: Row(
                  children: [
                    Icon(
                      FontAwesome.camera_solid,
                      color: AppColors.YELLOW,
                      size: 25,
                    ),
                    SizedBox(
                        width: 10), // Add some space between the icon and text
                    Text(
                      'Take a Photo',
                      style: TextStyle(
                        color: AppColors.BLUE, 
                      fontSize: screenWidth * 0.05),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02,),
              TextButton(
                onPressed: () => imageSelection(ImageSource.gallery),
                child: Row(
                  children: [
                    Icon(
                      FontAwesome.image,
                      color: AppColors.YELLOW,
                      size: 25,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Upload an Image',
                      style: TextStyle(color: AppColors.BLUE, 
                      fontSize: screenWidth * 0.05),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
