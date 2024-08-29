import 'package:eggventure/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key?key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/EggVenture.png',
                  width: 50,
                ),
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
                            color: Color(0xFF353E55),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ],
          )
      ),
      bottomNavigationBar: NavigationBarWidget(),
    );
  }
}

// git pull origin joel