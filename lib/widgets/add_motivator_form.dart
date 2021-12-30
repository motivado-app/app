import 'package:flutter/material.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';

class AddMotivatorForm extends StatefulWidget {
  const AddMotivatorForm({Key? key}) : super(key: key);

  @override
  State<AddMotivatorForm> createState() => _AddMotivatorFormState();
}

class _AddMotivatorFormState extends State<AddMotivatorForm> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        createInlinePicker(
          elevation: 1.5,
          borderRadius: 20,
          value: TimeOfDay.now(),
          onChange: (_) {},
          okStyle: TextStyle(color: Theme.of(context).primaryColor),
          cancelStyle: TextStyle(color: Theme.of(context).primaryColor),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
