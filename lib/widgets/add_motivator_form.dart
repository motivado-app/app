import 'package:flutter/material.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loader_overlay/loader_overlay.dart';

//Widgets

class AddMotivatorForm extends StatefulWidget {
  const AddMotivatorForm({Key? key}) : super(key: key);

  @override
  State<AddMotivatorForm> createState() => _AddMotivatorFormState();
}

class _AddMotivatorFormState extends State<AddMotivatorForm> {
  final _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 8),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 5,
        children: <Widget>[
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text(
                'Repeat :',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              ChoiceChip(
                visualDensity: VisualDensity.adaptivePlatformDensity,
                label: const Text('Everyday'),
                selectedColor: Theme.of(context).focusColor.withOpacity(0.8),
                selected: true,
                labelStyle: const TextStyle(color: Colors.black),
              ),
              ChoiceChip(
                visualDensity: VisualDensity.adaptivePlatformDensity,
                label: const Text('One-time'),
                selected: false,
                selectedColor: Theme.of(context).focusColor.withOpacity(0.8),
                labelStyle: const TextStyle(color: Colors.black),
              ),
            ],
            spacing: 20,
            // runSpacing: 10,
            alignment: WrapAlignment.spaceAround,
          ),
          createInlinePicker(
            isOnChangeValueMode: false,
            elevation: 1.5,
            borderRadius: 20,
            value: TimeOfDay.now(),
            onChange: (time) async {
              context.loaderOverlay.show();
              final now = new DateTime.now();
              CollectionReference alarmData = FirebaseFirestore.instance
                  .collection(_user!.uid)
                  .doc('alarms')
                  .collection('alarmData');

              await alarmData.add({
                'repeat': 'everyday',
                'time': DateTime(
                        now.year, now.month, now.day, time.hour, time.minute)
                    .toString(),
              }).then((value) {
                context.loaderOverlay.hide();
                Navigator.of(context).pop();
              }).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Sorry! Something went wrong'),
                  ),
                );
              });

              //Navigator.of(context).pop();
            },
            okStyle: TextStyle(color: Theme.of(context).primaryColor),
            cancelStyle: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
