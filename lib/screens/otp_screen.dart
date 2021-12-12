import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OtpScreen extends StatelessWidget {
  final String phoneNumber;
  OtpScreen(this.phoneNumber);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
                length: 4,
                width: MediaQuery.of(context).size.width - 20,
                fieldWidth: 50,
                style: const TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {
                  print("Completed: " + pin);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
