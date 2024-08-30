import 'package:eggventure/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

class TrayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: NavigationBarWidget(currentIndex: 3,),
    );
  }
}
