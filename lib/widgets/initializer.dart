// Packages
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Screens
import '../screens/login_screen.dart';
import '../screens/motivation_home_screen.dart';

class InitializerWidget extends StatefulWidget {
  const InitializerWidget({Key? key}) : super(key: key);

  @override
  _InitializerWidgetState createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  late FirebaseAuth _auth;
  var _user;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SvgPicture.asset(
                'assets/images/welcome.svg',
                fit: BoxFit.contain,
                width: 350,
              ),
            ),
          )
        : _user == null
            ? LoginScreen()
            : MotivationHomeScreen();
  }
}
