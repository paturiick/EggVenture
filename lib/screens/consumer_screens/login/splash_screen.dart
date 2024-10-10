import 'package:eggventure/screens/consumer_screens/login/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const WelcomeScreen(),
      ));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Image(
                image: AssetImage('assets/Eggventure.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'E',
                      style: TextStyle(
                        fontFamily: 'AvenirNextCyr',
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFF9B514),
                        fontSize: 32,
                      ),
                    ),
                    TextSpan(
                      text: 'GG',
                      style: TextStyle(
                        fontFamily: 'AvenirNextCyr',
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF353E55),
                        fontSize: 26,
                      ),
                    ),
                    TextSpan(
                      text: 'V',
                      style: TextStyle(
                        fontFamily: 'AvenirNextCyr',
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFF9B514),
                        fontSize: 32,
                      ),
                    ),
                    TextSpan(
                      text: 'ENTURE',
                      style: TextStyle(
                        fontFamily: 'AvenirNextCyr',
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF353E55),
                        fontSize: 26,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
