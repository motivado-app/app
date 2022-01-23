import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:isolate';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:system_alert_window/system_alert_window.dart' as alw;
import './system_alert.dart';

Future<void> _requestPermissions() async {
  await alw.SystemAlertWindow.requestPermissions(
      prefMode: alw.SystemWindowPrefMode.OVERLAY);
}

class MotivationAlarmTile extends StatefulWidget {
  final String time;
  final String repeat;
  MotivationAlarmTile(this.time, this.repeat);

  @override
  State<MotivationAlarmTile> createState() => _MotivationAlarmTileState();
}

class _MotivationAlarmTileState extends State<MotivationAlarmTile> {
  @override
  void initState() {
    super.initState();
    _requestPermissions();
    //alw.SystemAlertWindow.registerOnClickListener(callBack);
  }

  bool _alarmStatus = false;
  static void printHello() async {
    final DateTime now = DateTime.now();
    final int isolateId = Isolate.current.hashCode;
    await alw.SystemAlertWindow.requestPermissions;
    alw.SystemAlertWindow.showSystemWindow(
      height: 230,
      header: header,
      body: body,
      footer: footer,
      margin: alw.SystemWindowMargin(left: 8, right: 8, top: 100, bottom: 0),
      gravity: alw.SystemWindowGravity.TOP,
      notificationTitle: "Incoming Call",
      notificationBody: "+1 646 980 4741",
      prefMode: alw.SystemWindowPrefMode.OVERLAY,
    );

    AndroidAlarmManager.cancel(696969);
    AndroidAlarmManager.periodic(
      const Duration(seconds: 20),
      696969,
      printHello,
    );
  }

  void _setAlarm() async {
    final int helloAlarmID = 696969;
    await AndroidAlarmManager.periodic(
      const Duration(seconds: 15),
      helloAlarmID,
      printHello,
    );
    setState(() {
      _alarmStatus = !_alarmStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final time = TimeOfDay.fromDateTime(DateTime.parse(widget.time))
        .format(context)
        .split(' ');
    return Container(
      height: 110,
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
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
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
                time[1] == 'AM' ? '☀️ ${time[0]}' : '🌙 ${time[0]}',
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                time[1].toLowerCase(),
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
            ],
          ),
          title: Text(
            widget.repeat,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).focusColor,
              fontWeight: FontWeight.w300,
            ),
          ),
          trailing: CupertinoSwitch(
            value: _alarmStatus,
            onChanged: (_) => _setAlarm(),
            activeColor: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
