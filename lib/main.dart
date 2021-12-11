import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/motivation_home_screen.dart';
import './screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Motivation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthScreen(),
      routes: {
        MotivationHomeScreen.routeName: (ctx) => MotivationHomeScreen(),
      },
    );
  }
}
