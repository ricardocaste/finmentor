import 'dart:async';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    // AnalyticsService().currentScreen();
    Timer(const Duration(seconds: 1), () => handleSplashScreen(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/logo.png',
              width: 214,
              height: 214,
            ),
          )
        ],
      ),
    );
  }


  //handle splash screen
  void handleSplashScreen(BuildContext context) async {
    if (context.mounted) {  
      Navigator.of(context).pushNamed('nav');
    }
  }
}
