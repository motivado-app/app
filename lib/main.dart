// Packages
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

// Screens
import './screens/motivation_home_screen.dart';

// Widgets
import './widgets/initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Motivation',
      theme: ThemeData(
        primaryColor: const Color(0xff28282B),
        backgroundColor: Colors.white,
      ),
      home: InitializerWidget(),
      routes: {
        MotivationHomeScreen.routeName: (ctx) => MotivationHomeScreen(),
      },
    );
  }
}
