import 'package:eggventure/widgets/navigation_bar_farmer.dart';
import 'package:flutter/material.dart';

class AddProductScreenFarmer extends StatefulWidget {
  @override
  _AddProductScreenFarmerState createState() => _AddProductScreenFarmerState();
}

class _AddProductScreenFarmerState extends State<AddProductScreenFarmer> {
  final _productNameController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _sizeController = TextEditingController();
  final _eggTypeController = TextEditingController();

  @override
  void dispose() {
    _productNameController.dispose();
    _productDescriptionController.dispose();
    _sizeController.dispose();
    _eggTypeController.dispose();
    super.dispose();
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }

  Widget _buildImagePicker(String label) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Center(
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            // Logic to add an image
          },
        ),
      ),
    );
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Basic Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              _buildTextField('Product Name', _productNameController),
              _buildTextField('Product Description', _productDescriptionController),
              _buildTextField('Size', _sizeController),
              _buildTextField('Egg Type', _eggTypeController),
              SizedBox(height: 20),
              Text(
                'Media Management',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: <Widget>[
                  _buildImagePicker('Cover Photo'),
                  _buildImagePicker('Image 1'),
                  _buildImagePicker('Image 2'),
                  _buildImagePicker('Image 3'),
                  _buildImagePicker('Image 4'),
                  _buildImagePicker('Image 5'),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Logic for Cancel
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.grey),
                    ),
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Logic for Save and Delist
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      foregroundColor: Colors.black,
                    ),
                    child: Text('Save and Delist'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Logic for Save and Publish
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
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