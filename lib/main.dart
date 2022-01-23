// Packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:isolate';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:system_alert_window/system_alert_window.dart';

// Screens
import '../screens/login_screen.dart';
import '../screens/motivation_home_screen.dart';

// Widgets

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await AndroidAlarmManager.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp(
        //debugShowCheckedModeBanner: false,
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
      ),
    );
  }
}
