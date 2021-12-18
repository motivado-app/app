import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    final double _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    final double _screenWidth = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).focusColor,
        onPressed: () {},
        child: Icon(
          Icons.add,
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
              height: _screenHeight * 0.5,
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
            height: _screenHeight * 0.48,
            child: ListView.builder(
              itemBuilder: (ctx, idx) {
                return MotivationAlarmTile(_alarmStatus, _setAlarm);
              },
              itemCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
