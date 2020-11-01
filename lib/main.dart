import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:codechallenge/views/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Code Challenge',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnimatedSplashScreen(
        nextScreen: Auth(),
        duration: 2000,
        splash: Image.network(
            'https://www.tinypulse.com/hs-fs/hubfs/best_companies_helloworld_1.pngw300.png?width=400&name=best_companies_helloworld_1.pngw300.png'),
        splashTransition: SplashTransition.sizeTransition,
        pageTransitionType: PageTransitionType.fade,
      ),
    );
  }
}
