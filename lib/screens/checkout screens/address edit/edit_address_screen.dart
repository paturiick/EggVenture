import 'package:flutter/material.dart';

class EditAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Edit Address",
          style: TextStyle(
              color: Color(0xFF353E55),
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Address Editing Screen"),
      ),
    );
  }
}
