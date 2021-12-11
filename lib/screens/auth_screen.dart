import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './motivation_home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _phnum = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    controller: _phnum,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _auth.verifyPhoneNumber(
                        phoneNumber: '+919073697597',
                        verificationCompleted:
                            (PhoneAuthCredential credential) async {
                          await _auth.signInWithCredential(credential);
                          Navigator.of(context)
                              .pushNamed(MotivationHomeScreen.routeName);
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          if (e.code == 'invalid-phone-number') {
                            print('The provided phone number is not valid.');
                          }
                        },
                        codeSent: (String verificationId, int? resendToken) {},
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },
                    child: const Text('Login'),
                  ),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
