import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {
  SettingsForm({Key key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['1', '2', '3', '4', '5'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              'Обновите свои предпочтения',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20),
            TextFormField(
              validator: (val) =>
                  val.isEmpty ? 'Пожалуйста, укажите свое имя' : null,
              onChanged: (val) => setState(() => _currentName = val),
            )
          ],
        ),
      ),
    );
  }
}
