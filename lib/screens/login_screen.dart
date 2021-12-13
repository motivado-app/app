// Packages
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

// Screens
import './motivation_home_screen.dart';

// Widgets

enum MobileVerificationState {
  showMobileForm,
  showOtpForm,
}

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _currSate = MobileVerificationState.showMobileForm;
  final _phNum = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String verificationId;
  bool _showloading = false;

  void signInWithPhoneAuthCredential(PhoneAuthCredential cred) async {
    setState(() {
      _showloading = true;
    });
    try {
      final authCredential = await _auth.signInWithCredential(cred);
      setState(() {
        _showloading = false;
      });

      if (authCredential.user != null) {
        Navigator.of(context)
            .pushReplacementNamed(MotivationHomeScreen.routeName);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _showloading = false;
      });
    }
  }

  void _verificationFailed(verificationFailed) {
    setState(() {
      _showloading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(verificationFailed.message.toString()),
      ),
    );
  }

  void _codeSent(verifyId, resendingToken) {
    setState(() {
      //_currSate = MobileVerificationState.showOtpForm;
      _showloading = false;
      verificationId = verifyId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: _showloading
          ? const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : _currSate == MobileVerificationState.showMobileForm
              ? Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/images/welcome.svg',
                          fit: BoxFit.contain,
                          width: 350,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: const Text(
                            'Welcome to Daily Motivation',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 2,
                          ),
                          child: TextField(
                            controller: _phNum,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'Enter Phone Number',
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10)),
                              prefix: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  '(+91)',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              suffixIcon: const Icon(
                                Icons.call,
                                color: Colors.grey,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _currSate = MobileVerificationState.showOtpForm;
                            });

                            await _auth.verifyPhoneNumber(
                              phoneNumber: '+91${_phNum.text}',
                              verificationCompleted: (credential) {
                                // signInWithPhoneAuthCredential(credential);
                              },
                              verificationFailed: _verificationFailed,
                              codeSent: _codeSent,
                              codeAutoRetrievalTimeout: (verificationId) {},
                            );
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/images/security.svg',
                          fit: BoxFit.contain,
                          width: 260,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: const Text(
                            'Enter OTP sent to your mobile',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        OTPTextField(
                          length: 6,
                          width: MediaQuery.of(context).size.width - 40,
                          fieldWidth: 40,
                          style: const TextStyle(fontSize: 17),
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldStyle: FieldStyle.underline,
                          onCompleted: (pin) {
                            PhoneAuthCredential phoneAuthCredential =
                                PhoneAuthProvider.credential(
                              verificationId: verificationId,
                              smsCode: pin,
                            );
                            signInWithPhoneAuthCredential(phoneAuthCredential);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
