import 'package:flutter/material.dart';
import 'package:expendable_fab/expendable_fab.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpendableFab(
      distance: 80,
      children: [
        Column(
          children: [
            ActionButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: Icon(
                Icons.logout,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              'Log Out',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        Column(
          children: [
            ActionButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              'Add Motivator',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        )
      ],
    );
  }
}
