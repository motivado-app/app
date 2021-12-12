import 'package:flutter/material.dart';

class MotivationHomeScreen extends StatelessWidget {
  static const routeName = '/motivation-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Daily Motivation'),
      ),
      body: Center(
        child: const Text('Welcome to The Daily Motivation'),
      ),
    );
  }
}
