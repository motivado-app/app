import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../widgets/motivation_alarm_tile.dart';
import '../widgets/empty_motivators.dart';
import '../widgets/floating_button.dart';

class MotivationHomeScreen extends StatelessWidget {
  static const routeName = '/motivation-home';

  @override
  Widget build(BuildContext context) {
    final _user = FirebaseAuth.instance.currentUser;

    final double _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    final double _screenWidth = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;

    return Scaffold(
      backgroundColor: Colors.white,
      // floatingActionButtonLocation: FloatingActionButtonLocation.,
      floatingActionButton: const FloatingButton(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: SvgPicture.asset(
              'assets/images/welcome.svg',
              height: _screenHeight * 0.4,
            ),
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('app_variables')
                  .doc('motivation-home-screen')
                  .snapshots(),
              builder: (ctx, AsyncSnapshot snpShot) {
                if (snpShot.connectionState == ConnectionState.waiting) {
                  context.loaderOverlay.show();
                  return const Text('');
                }
                context.loaderOverlay.hide();
                return Container(
                  width: _screenWidth * 0.7,
                  child: Text(
                    snpShot.data['quote'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black54),
                    textAlign: TextAlign.center,
                    textWidthBasis: TextWidthBasis.longestLine,
                  ),
                );
              }),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(_user!.uid)
                  .doc('alarms')
                  .collection('alarmData')
                  .snapshots(),
              builder: (ctx, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  context.loaderOverlay.show();
                  return EmptyMotivators();
                }

                context.loaderOverlay.hide();
                return snapshot.data.docs.length == 0
                    ? const EmptyMotivators()
                    : ListView(
                        // shrinkWrap: true,
                        children: snapshot.data.docs.map<Widget>((document) {
                          return MotivationAlarmTile(
                            document['time'],
                            document['repeat'],
                          );
                        }).toList(),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
