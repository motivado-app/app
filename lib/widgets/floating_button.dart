import 'package:flutter/material.dart';
import 'package:expendable_fab/expendable_fab.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './add_motivator_form.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpendableFab(
      distance: 95,
      children: [
        Column(
          children: [
            ActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        title: const Text('Confirm'),
                        content:
                            const Text('Are you sure you want to log out?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              FirebaseAuth.instance.signOut();
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    });
              },
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
              onPressed: () {
                showModalBottomSheet<dynamic>(
                  isScrollControlled: true,
                  context: context,
                  builder: (_) {
                    return const AddMotivatorForm();
                  },
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                );
              },
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
