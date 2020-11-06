import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drinkapp/models/drink.dart';
import 'package:drinkapp/screens/home/DrinksList.dart';
import 'package:drinkapp/screens/home/settingsform.dart';
import 'package:drinkapp/services/auth.dart';
import 'package:drinkapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  //const Home({Key key}) : super(key: key);

  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.fromLTRB(60, 20, 60, 20),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Drink>>.value(
      value: DatabaseService().drinks,
      child: Scaffold(
        backgroundColor: Colors.brown[200],
        appBar: AppBar(
          title: Text('App Drink'),
          backgroundColor: Colors.brown[400],
          actions: [
            FlatButton.icon(
              onPressed: () async {
                await _auth.logOut();
              },
              icon: Icon(Icons.person),
              label: Text('Выход'),
            ),
            FlatButton.icon(
              onPressed: () {
                _showSettingsPanel();
              },
              icon: Icon(Icons.settings),
              label: Text('Настройки'),
            ),
          ],
        ),
        body: DrinkList(),
      ),
    );
  }
}
