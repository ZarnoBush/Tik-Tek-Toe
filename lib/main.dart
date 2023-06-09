import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:tic_tec_toe/screen/game_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        duration: 3000,
        backgroundColor: Colors.black,
        splash: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Icon(
                  Icons.games,
                  size: 40,
                  color: Colors.yellow[600],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  'AyZapp Games',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        nextScreen: GamePage(),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}
