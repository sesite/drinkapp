import 'package:drinkapp/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  //const Home({Key key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              label: Text('Выход'))
        ],
      ),
    );
  }
}
