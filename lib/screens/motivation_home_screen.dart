import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/motivation_alarm_tile.dart';

class MotivationHomeScreen extends StatefulWidget {
  static const routeName = '/motivation-home';

  @override
  State<MotivationHomeScreen> createState() => _MotivationHomeScreenState();
}

class _MotivationHomeScreenState extends State<MotivationHomeScreen> {
  bool _alarmStatus = false;
  void _setAlarm() {
    setState(() {
      _alarmStatus = !_alarmStatus;
    });
  }

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).focusColor,
        onPressed: () {
          FirebaseAuth.instance.signOut();
        },
        child: Icon(
          Icons.logout,
          color: Theme.of(context).primaryColor,
        ),
      ),
      // appBar: AppBar(
      //   //toolbarHeight: 60,
      //   backgroundColor: Theme.of(context).primaryColor,
      //   title: const Text('Daily Motivation'),
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: SvgPicture.asset(
              'assets/images/welcome.svg',
              height: _screenHeight * 0.4,
            ),
          ),
          Container(
            width: _screenWidth * 0.7,
            child: const Text(
              '"Everyone has a god, they just call it different names"',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
              textAlign: TextAlign.center,
              textWidthBasis: TextWidthBasis.longestLine,
            ),
          ),
          Container(
            height: _screenHeight * 0.582,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(_user!.uid)
                  .doc('alarms')
                  .collection('alarmData')
                  .snapshots(),
              builder: (ctx, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return ListView(
                  children: snapshot.data.docs.map<Widget>((document) {
                    return MotivationAlarmTile(
                      _alarmStatus,
                      _setAlarm,
                      document['time'],
                      document['repeat'],
                    );
                  }).toList(),
                );
              },
            ),
          ),
          // Container(
          //   height: _screenHeight * 0.582,
          //   child: ListView.builder(
          //     itemBuilder: (ctx, idx) {
          //       return MotivationAlarmTile(_alarmStatus, _setAlarm);
          //     },
          //     itemCount: 6,
          //   ),
          // ),
        ],
      ),
    );
  }
}
