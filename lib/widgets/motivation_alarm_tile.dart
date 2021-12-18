import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MotivationAlarmTile extends StatelessWidget {
  var setAlarm;
  final bool alarmStatus;

  MotivationAlarmTile(this.alarmStatus, this.setAlarm);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      //width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Center(
        child: ListTile(
          leading: const Text(
            '☀️ 10:00',
            style: TextStyle(fontSize: 34),
          ),
          title: Text(
            'Everyday',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.w300,
            ),
          ),
          trailing: CupertinoSwitch(
            value: alarmStatus,
            onChanged: (_) => setAlarm(),
            activeColor: Theme.of(context).focusColor,
          ),
        ),
      ),
    );
  }
}
