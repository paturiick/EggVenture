import 'package:eggventure/widgets/navigation_bar_farmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:eggventure/routes/routes.dart';


class HomeScreenFarmer extends StatelessWidget {
    const HomeScreenFarmer({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: 
              CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/Eggventure.png',
                        width: 50,
                        ),
                      SizedBox(width: 10),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'E',
                              style: TextStyle(
                                fontFamily: 'AvenirNextCyr',
                                fontWeight: FontWeight.w700,
                                fontSize: 32,
                                color: Color(0xFFF9B514),                             
                              ),
                            ),
                            TextSpan(
                              text: 'GG',
                              style: TextStyle(
                                fontFamily: 'AvenirNextCyr',
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                                color: Color(0xFF353E55),
                              ),
                            ),
                            TextSpan(
                              text: 'V',
                              style: TextStyle(
                                fontFamily: 'AvenirNextCyr',
                                fontWeight: FontWeight.w700,
                                fontSize: 32,
                                color: Color(0xFFF9B514),
                              ),
                            ),
                            TextSpan(
                              text: 'ENTURE',
                              style: TextStyle(
                                fontFamily: 'AvenirNextCyr',
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                                color: Color(0xFF353E55)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ), 
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(AntDesign.search_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none
                ),
                filled: true,
                fillColor: Color(0xFFF5F5F5),
              ),
            ),
          ),
        ],
      ),
    ),
    bottomNavigationBar: NavigationBarWidgetFarmer(currentIndex: 0,)
  );
}
}
