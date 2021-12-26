// Packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

// Screens
import '../screens/login_screen.dart';
import '../screens/motivation_home_screen.dart';

// Widgets

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
      title: 'Motivado',
      theme: ThemeData(
        primaryColor: const Color(0xff28282B),
        backgroundColor: Colors.white,
        accentColor: const Color(0xff64fcd9),
        focusColor: const Color(0xffffb61d),
      ),
      //home: InitializerWidget(),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return MotivationHomeScreen();
            }
            return LoginScreen();
          }),
      routes: {
        MotivationHomeScreen.routeName: (ctx) => MotivationHomeScreen(),
      },
    );
  }
}
