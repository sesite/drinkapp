import 'package:drinkapp/models/user.dart';
import 'package:drinkapp/screens/home/loading.dart';
import 'package:drinkapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final user = Provider.of<UserApp>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Обновите свои предпочтения',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: snapshot.data.name,
                    decoration:
                        InputDecoration(hintText: 'укажите свое имя...'),
                    validator: (val) =>
                        val.isEmpty ? 'Пожалуйста, укажите свое имя' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 18),
                  DropdownButtonFormField(
                    value: _currentSugars ?? snapshot.data.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar кубика сахара'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text('Крепость'),
                      Expanded(
                        child: Slider(
                          min: 100.0,
                          max: 900.0,
                          value: (_currentStrength ?? snapshot.data.strength)
                              .toDouble(),
                          divisions: 8,
                          label: _currentStrength.toString(),
                          activeColor: Colors.brown[
                              _currentStrength ?? snapshot.data.strength],
                          inactiveColor: Colors.brown[
                              _currentStrength ?? snapshot.data.strength],
                          onChanged: (val) =>
                              setState(() => _currentStrength = val.toInt()),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  RaisedButton(
                      color: Colors.pink[200],
                      child: Text('Обновить',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars ?? snapshot.data.sugars,
                              _currentName ?? snapshot.data.name,
                              _currentStrength ?? snapshot.data.strength);
                          Navigator.pop(context);
                        }
                      })
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
