import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_app/screens/Homepage.dart';
import 'package:login_app/screens/SignIn.dart';
import 'package:login_app/screens/SignUp.dart';
import 'package:login_app/screens/introscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'IntroScreen',
      routes: {
        'sign_up': (context) => const SignUp(),
        '/': (context) => const HomePage(),
        'sign_in': (context) => const SignIn(),
        'IntroScreen': (context) => const IntroScreen(),
      },
    ),
  );
}
