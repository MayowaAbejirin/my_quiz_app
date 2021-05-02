import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_quiz_app/ui/splashscreen.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(
    new MaterialApp(
      home: QuizSplashScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
