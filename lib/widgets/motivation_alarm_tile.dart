import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MotivationAlarmTile extends StatelessWidget {
  var setAlarm;
  final bool alarmStatus;
  final String time;
  final String repeat;

  MotivationAlarmTile(this.alarmStatus, this.setAlarm, this.time, this.repeat);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      //width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
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
          horizontalTitleGap: 5,
          // leading: const Text(
          //   '☀️ 10:00',
          //   style: TextStyle(fontSize: 28),
          // ),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '☀️ $time',
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                'am',
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
            ],
          ),
          title: Text(
            repeat,
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
